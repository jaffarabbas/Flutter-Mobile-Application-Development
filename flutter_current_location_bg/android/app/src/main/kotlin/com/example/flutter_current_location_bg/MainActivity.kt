package com.example.flutter_current_location_bg

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import com.example.flutter_current_location_bg.tracking.LocationService
import com.example.flutter_current_location_bg.tracking.PointBus
import com.example.flutter_current_location_bg.tracking.TrackerDb
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val CONTROL_CHANNEL = "tracker/control"
        private const val POINTS_CHANNEL = "tracker/points"

        private const val REQ_FOREGROUND = 1001
        private const val REQ_BACKGROUND = 1002
        private const val REQ_NOTIFICATIONS = 1003
    }

    /** Pending result of requestPermissions(); completed when the whole chain finishes. */
    private var permissionResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, CONTROL_CHANNEL).setMethodCallHandler(::onMethodCall)

        EventChannel(messenger, POINTS_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                PointBus.listener = { events.success(it) }
            }

            override fun onCancel(arguments: Any?) {
                PointBus.listener = null
            }
        })
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        PointBus.listener = null
        super.cleanUpFlutterEngine(flutterEngine)
    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startRide" -> {
                val rideId = call.argument<String>("rideId")
                if (rideId.isNullOrBlank()) {
                    result.error("ARG", "rideId required", null)
                } else if (!has(Manifest.permission.ACCESS_FINE_LOCATION)) {
                    result.error("PERMISSION", "Fine location permission not granted", null)
                } else {
                    LocationService.start(this, rideId)
                    result.success(true)
                }
            }
            "stopRide" -> {
                LocationService.stop(this)
                result.success(true)
            }
            "isTracking" -> {
                val rideId = LocationService.activeRideId(this)
                // Ride is active but the service died and was not restarted: revive it while in foreground.
                if (rideId != null && !LocationService.isRunning && has(Manifest.permission.ACCESS_FINE_LOCATION)) {
                    LocationService.start(this, rideId)
                }
                result.success(mapOf("tracking" to (rideId != null), "rideId" to rideId))
            }
            "getDbPath" -> {
                TrackerDb.get(this).writableDatabase // make sure the file + schema exist
                result.success(TrackerDb.path(this))
            }
            "getPermissionStatus" -> result.success(permissionStatus())
            "requestPermissions" -> {
                if (permissionResult != null) {
                    result.error("BUSY", "Permission request already in progress", null)
                    return
                }
                permissionResult = result
                requestNextPermission()
            }
            "openBatteryOptimizationSettings" -> {
                openBatterySettings()
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    // --- Permissions: FINE -> BACKGROUND -> NOTIFICATIONS, one step at a time ---

    private fun requestNextPermission() {
        when {
            !has(Manifest.permission.ACCESS_FINE_LOCATION) ->
                requestPermissions(
                    arrayOf(Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION),
                    REQ_FOREGROUND
                )
            !has(Manifest.permission.ACCESS_BACKGROUND_LOCATION) && !askedThisRound(REQ_BACKGROUND) ->
                requestPermissions(arrayOf(Manifest.permission.ACCESS_BACKGROUND_LOCATION), REQ_BACKGROUND)
            Build.VERSION.SDK_INT >= 33 && !has(Manifest.permission.POST_NOTIFICATIONS) &&
                !askedThisRound(REQ_NOTIFICATIONS) ->
                requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), REQ_NOTIFICATIONS)
            else -> finishPermissionChain()
        }
    }

    private val askedCodes = mutableSetOf<Int>()
    private fun askedThisRound(code: Int) = code in askedCodes

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (permissionResult == null) return
        askedCodes += requestCode
        if (requestCode == REQ_FOREGROUND && !has(Manifest.permission.ACCESS_FINE_LOCATION)) {
            // User denied fine location: nothing else makes sense to ask.
            finishPermissionChain()
            return
        }
        requestNextPermission()
    }

    private fun finishPermissionChain() {
        askedCodes.clear()
        permissionResult?.success(permissionStatus())
        permissionResult = null
    }

    private fun permissionStatus(): Map<String, Any> {
        val pm = getSystemService(PowerManager::class.java)
        return mapOf(
            "platform" to "android",
            "fineLocation" to has(Manifest.permission.ACCESS_FINE_LOCATION),
            "backgroundLocation" to has(Manifest.permission.ACCESS_BACKGROUND_LOCATION),
            "notifications" to (Build.VERSION.SDK_INT < 33 || has(Manifest.permission.POST_NOTIFICATIONS)),
            "ignoringBatteryOptimizations" to pm.isIgnoringBatteryOptimizations(packageName),
        )
    }

    private fun has(permission: String) =
        checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED

    // --- Battery optimization (critical on Xiaomi/Oppo/Vivo/Infinix/Tecno) ---

    private fun openBatterySettings() {
        val pm = getSystemService(PowerManager::class.java)
        val intents = buildList {
            if (!pm.isIgnoringBatteryOptimizations(packageName)) {
                add(Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS, Uri.parse("package:$packageName")))
            }
            add(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
            add(Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:$packageName")))
        }
        // Some OEM ROMs strip these screens; fall through to the next one that exists.
        for (intent in intents) {
            try {
                startActivity(intent)
                return
            } catch (_: Exception) {
            }
        }
    }
}
