package com.example.flutter_current_location_bg.tracking

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ServiceInfo
import android.location.Location
import android.os.Build
import android.os.HandlerThread
import android.os.IBinder
import android.os.PowerManager
import android.util.Log
import com.example.flutter_current_location_bg.MainActivity
import com.example.flutter_current_location_bg.R
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import java.util.UUID

/**
 * Foreground service that owns GPS tracking and writes every fix to SQLite.
 * Survives the Flutter engine / activity being destroyed (swipe-away).
 */
class LocationService : Service() {

    companion object {
        private const val TAG = "LocationService"
        const val ACTION_START = "tracker.START"
        const val ACTION_STOP = "tracker.STOP"
        const val EXTRA_RIDE_ID = "rideId"

        private const val CHANNEL_ID = "ride_tracking"
        private const val NOTIFICATION_ID = 4711
        private const val INTERVAL_MS = 1000L

        private const val PREFS = "tracker_prefs"
        private const val KEY_ACTIVE_RIDE = "active_ride_id"

        @Volatile
        var isRunning = false
            private set

        fun activeRideId(context: Context): String? =
            context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(KEY_ACTIVE_RIDE, null)

        private fun setActiveRideId(context: Context, rideId: String?) {
            // commit() (synchronous) so the id is on disk before we start recording.
            context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
                .apply { if (rideId == null) remove(KEY_ACTIVE_RIDE) else putString(KEY_ACTIVE_RIDE, rideId) }
                .commit()
        }

        fun start(context: Context, rideId: String) {
            val i = Intent(context, LocationService::class.java)
                .setAction(ACTION_START)
                .putExtra(EXTRA_RIDE_ID, rideId)
            context.startForegroundService(i)
        }

        fun stop(context: Context) {
            val rideId = activeRideId(context)
            if (!isRunning) {
                // Service is not alive (e.g. killed and not restarted): close the ride directly.
                if (rideId != null) TrackerDb.get(context).endRide(rideId, System.currentTimeMillis())
                setActiveRideId(context, null)
                return
            }
            context.startService(Intent(context, LocationService::class.java).setAction(ACTION_STOP))
        }
    }

    private lateinit var fused: FusedLocationProviderClient
    private lateinit var db: TrackerDb
    private var workerThread: HandlerThread? = null
    private var wakeLock: PowerManager.WakeLock? = null
    private val filter = PointFilter()
    @Volatile
    private var rideId: String? = null

    private val callback = object : LocationCallback() {
        override fun onLocationResult(result: LocationResult) {
            for (loc in result.locations) handleLocation(loc)
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        fused = LocationServices.getFusedLocationProviderClient(this)
        db = TrackerDb.get(this)
        createChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            stopRide()
            return START_NOT_STICKY
        }

        // ACTION_START from the UI, or null intent when the system restarts us (START_STICKY).
        val id = intent?.getStringExtra(EXTRA_RIDE_ID) ?: activeRideId(this)
        if (id == null) {
            stopSelf()
            return START_NOT_STICKY
        }

        if (!enterForeground()) {
            // Could not become foreground (permission revoked or background-start restriction).
            // Keep the ride marked active; the UI restarts the service when opened.
            stopSelf()
            return START_NOT_STICKY
        }

        if (rideId != id) beginRide(id)
        return START_STICKY
    }

    private fun enterForeground(): Boolean {
        if (checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            Log.w(TAG, "Fine location not granted, cannot track")
            return false
        }
        return try {
            startForeground(NOTIFICATION_ID, buildNotification(), ServiceInfo.FOREGROUND_SERVICE_TYPE_LOCATION)
            isRunning = true
            true
        } catch (e: Exception) {
            // ForegroundServiceStartNotAllowedException (API 31+) or SecurityException (API 34+).
            Log.e(TAG, "startForeground failed", e)
            false
        }
    }

    private fun beginRide(id: String) {
        stopLocationUpdates()
        rideId = id
        setActiveRideId(this, id)
        db.startRide(id, System.currentTimeMillis())
        filter.lastGood = db.lastGoodPoint(id)
        acquireWakeLock()

        val thread = HandlerThread("tracker-location").also { it.start() }
        workerThread = thread

        val request = LocationRequest.Builder(Priority.PRIORITY_HIGH_ACCURACY, INTERVAL_MS)
            .setMinUpdateIntervalMillis(INTERVAL_MS)
            .setMinUpdateDistanceMeters(0f)
            .setMaxUpdateDelayMillis(0) // no batching: deliver each fix immediately
            .setWaitForAccurateLocation(false)
            .build()
        try {
            fused.requestLocationUpdates(request, callback, thread.looper)
        } catch (e: SecurityException) {
            Log.e(TAG, "requestLocationUpdates denied", e)
        }
    }

    /** Runs on the worker thread: filter, insert, then stream to Flutter. */
    private fun handleLocation(loc: Location) {
        val id = rideId ?: return
        val mocked = if (Build.VERSION.SDK_INT >= 31) loc.isMock else @Suppress("DEPRECATION") loc.isFromMockProvider
        val accuracy = if (loc.hasAccuracy()) loc.accuracy.toDouble() else null
        val speed = if (loc.hasSpeed()) loc.speed.toDouble() else null
        val reason = filter.evaluate(loc.latitude, loc.longitude, accuracy, speed, mocked, loc.time)

        val point = TrackPoint(
            id = UUID.randomUUID().toString(),
            rideId = id,
            lat = loc.latitude,
            lng = loc.longitude,
            accuracy = accuracy,
            altitude = if (loc.hasAltitude()) loc.altitude else null,
            speed = speed,
            bearing = if (loc.hasBearing()) loc.bearing.toDouble() else null,
            provider = loc.provider ?: "fused",
            isMocked = mocked,
            isFiltered = reason != null,
            filterReason = reason,
            recordedAt = loc.time,
        )
        try {
            db.insertPoint(point)
        } catch (e: Exception) {
            Log.e(TAG, "insert failed", e)
        }
        PointBus.publish(point)
    }

    private fun stopRide() {
        val id = rideId ?: activeRideId(this)
        stopLocationUpdates()
        if (id != null) db.endRide(id, System.currentTimeMillis())
        setActiveRideId(this, null)
        rideId = null
        releaseWakeLock()
        stopForeground(STOP_FOREGROUND_REMOVE)
        isRunning = false
        stopSelf()
    }

    private fun stopLocationUpdates() {
        fused.removeLocationUpdates(callback)
        workerThread?.quitSafely()
        workerThread = null
    }

    override fun onDestroy() {
        // Do not end the ride here: the system may destroy us and restart via START_STICKY.
        stopLocationUpdates()
        releaseWakeLock()
        isRunning = false
        super.onDestroy()
    }

    private fun acquireWakeLock() {
        if (wakeLock?.isHeld == true) return
        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "tracker:ride").apply {
            setReferenceCounted(false)
            acquire(12 * 60 * 60 * 1000L) // safety cap: 12 h
        }
    }

    private fun releaseWakeLock() {
        wakeLock?.let { if (it.isHeld) it.release() }
        wakeLock = null
    }

    private fun createChannel() {
        val nm = getSystemService(NotificationManager::class.java)
        if (nm.getNotificationChannel(CHANNEL_ID) == null) {
            nm.createNotificationChannel(
                NotificationChannel(CHANNEL_ID, "Ride tracking", NotificationManager.IMPORTANCE_LOW)
            )
        }
    }

    private fun buildNotification(): Notification {
        val open = PendingIntent.getActivity(
            this, 0,
            Intent(this, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
        val builder = Notification.Builder(this, CHANNEL_ID)
            .setContentTitle("Ride in progress")
            .setContentText("Recording GPS location")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setOngoing(true)
            .setContentIntent(open)
            .setCategory(Notification.CATEGORY_NAVIGATION)
        if (Build.VERSION.SDK_INT >= 31) {
            builder.setForegroundServiceBehavior(Notification.FOREGROUND_SERVICE_IMMEDIATE)
        }
        return builder.build()
    }
}
