package com.example.flutter_current_location_bg.tracking

import android.content.Context
import android.util.Log
import org.json.JSONArray
import org.json.JSONObject
import java.io.IOException
import java.net.HttpRetryException
import java.net.HttpURLConnection
import java.net.MalformedURLException
import java.net.URL
import java.util.concurrent.Executors

/**
 * Uploads unsynced rides/points to the server (docs/SYNC_API.md, "Client sync rules").
 * Keep behavior in sync with ios/Runner/SyncManager.swift.
 *
 * Process-scoped (not tied to LocationService), so the final pass after Stop Ride
 * still runs while the process lives. All network + sync DB work happens on one
 * background thread, so passes never overlap and tracking never waits on sync.
 */
object SyncManager {
    private const val TAG = "SyncManager"

    private const val THROTTLE_MS = 10_000L
    private const val BACKOFF_MIN_MS = 10_000L
    private const val BACKOFF_MAX_MS = 5 * 60_000L
    private const val BATCH_SIZE = 500
    private const val CONNECT_TIMEOUT_MS = 10_000
    private const val READ_TIMEOUT_MS = 20_000

    private const val PREFS = "tracker_sync_state"
    private const val KEY_LAST_SYNC_AT = "last_sync_at"
    private const val KEY_LAST_ERROR = "last_error"
    private const val KEY_BLOCKED = "blocked"

    private enum class Trigger {
        /** Fix inserted / app open: throttled to ~10 s, respects backoff and the 400 block. */
        AUTO,

        /** Stop Ride / config saved: ignores throttle and backoff, respects the 400 block. */
        SOON,

        /** "Sync now": ignores everything and clears the 400 block. */
        MANUAL,
    }

    private val executor = Executors.newSingleThreadExecutor { r ->
        Thread(r, "tracker-sync").apply { isDaemon = true }
    }

    /** Status reads (COUNT queries) for the UI; must not wait behind a slow upload. */
    private val statusExecutor = Executors.newSingleThreadExecutor { r ->
        Thread(r, "tracker-sync-status").apply { isDaemon = true }
    }

    // Guarded by `lock`.
    private val lock = Any()
    private var queued = false
    private val waiters = mutableListOf<(Map<String, Any?>) -> Unit>()
    private var lastStartAt = 0L
    private var backoffMs = 0L
    private var retryAt = 0L

    @Volatile
    var isSyncing = false
        private set

    // --- Public API (cheap; safe to call from any thread, including main) ---

    /** [force] = manual "Sync now". [onDone] gets the status map (on a background thread). */
    fun requestSync(context: Context, force: Boolean = false, onDone: ((Map<String, Any?>) -> Unit)? = null) =
        request(context, if (force) Trigger.MANUAL else Trigger.AUTO, onDone)

    /** Final upload after Stop Ride, so the "ended" status reaches the server promptly. */
    fun syncAfterStop(context: Context) = request(context, Trigger.SOON, null)

    /** Saves config, clears the 400 block / backoff, then kicks a pass. */
    fun updateConfig(context: Context, baseUrl: String, apiKey: String, enabled: Boolean): SyncConfig {
        val app = context.applicationContext
        val config = SyncConfig.save(app, baseUrl, apiKey, enabled)
        synchronized(lock) {
            backoffMs = 0
            retryAt = 0
        }
        state(app).edit().putBoolean(KEY_BLOCKED, false).remove(KEY_LAST_ERROR).apply()
        request(app, Trigger.SOON, null)
        return config
    }

    fun statusAsync(context: Context, onDone: (Map<String, Any?>) -> Unit) {
        val app = context.applicationContext
        statusExecutor.execute { onDone(status(app)) }
    }

    fun configMap(context: Context): Map<String, Any?> {
        val c = SyncConfig.load(context)
        return mapOf(
            "baseUrl" to c.baseUrl,
            "apiKey" to c.apiKey,
            "enabled" to c.enabled,
            "deviceId" to SyncConfig.deviceId(context),
        )
    }

    // --- Scheduling ---

    private fun request(context: Context, trigger: Trigger, onDone: ((Map<String, Any?>) -> Unit)?) {
        val app = context.applicationContext
        if (!SyncConfig.load(app).isUsable) {
            onDone?.let { statusAsync(app, it) }
            return
        }
        val now = System.currentTimeMillis()
        synchronized(lock) {
            if (trigger == Trigger.MANUAL) {
                state(app).edit().putBoolean(KEY_BLOCKED, false).apply()
            } else {
                val blocked = state(app).getBoolean(KEY_BLOCKED, false)
                val throttled = trigger == Trigger.AUTO && (now - lastStartAt < THROTTLE_MS || now < retryAt)
                if (blocked || throttled) {
                    onDone?.let { statusAsync(app, it) }
                    return
                }
            }
            lastStartAt = now
            onDone?.let { waiters += it }
            // A pass already waiting will pick up everything that is pending now.
            if (queued) return
            queued = true
        }
        executor.execute { runQueued(app) }
    }

    private fun runQueued(app: Context) {
        val callbacks: List<(Map<String, Any?>) -> Unit>
        synchronized(lock) {
            queued = false
            callbacks = waiters.toList()
            waiters.clear()
        }
        isSyncing = true
        try {
            runPass(app)
        } catch (e: Exception) {
            // Never let a DB/JSON surprise kill the sync thread.
            Log.e(TAG, "sync pass failed", e)
            fail(app, "Sync failed: ${e.message ?: e.javaClass.simpleName}", retry = true)
        } finally {
            isSyncing = false
        }
        if (callbacks.isNotEmpty()) {
            val s = status(app)
            callbacks.forEach { it(s) }
        }
    }

    // --- One pass: rides first, then points oldest first ---

    private fun runPass(app: Context) {
        val config = SyncConfig.load(app)
        if (!config.isUsable) return
        val deviceId = SyncConfig.deviceId(app)
        val db = TrackerDb.get(app)

        for (ride in db.pendingRides()) {
            val body = JSONObject()
                .put("deviceId", deviceId)
                .put("startedAt", ride.startedAt)
                .put("endedAt", ride.endedAt ?: JSONObject.NULL)
                .put("status", ride.status)
            val res = send("PUT", "${config.baseUrl}/api/v1/rides/${ride.id}", body, config.apiKey)
            if (!accept(app, res)) return
            db.markRideSynced(ride)
        }

        while (true) {
            val points = db.pendingPoints(BATCH_SIZE)
            if (points.isEmpty()) break
            val arr = JSONArray()
            points.forEach { arr.put(it.toJson()) }
            val body = JSONObject().put("deviceId", deviceId).put("points", arr)
            val res = send("POST", "${config.baseUrl}/api/v1/points/batch", body, config.apiKey)
            if (!accept(app, res)) return
            db.markPointsSynced(points.map { it.id })
            // A short batch means we caught up; new fixes go in the next pass.
            if (points.size < BATCH_SIZE) break
        }

        synchronized(lock) {
            backoffMs = 0
            retryAt = 0
        }
        state(app).edit()
            .putLong(KEY_LAST_SYNC_AT, System.currentTimeMillis())
            .remove(KEY_LAST_ERROR)
            .apply()
    }

    /** True to continue the pass; false after recording the error. */
    private fun accept(app: Context, res: HttpResult): Boolean = when (res) {
        is HttpResult.Ok -> true
        is HttpResult.BadUrl -> fail(app, "Invalid server URL: ${res.message}", retry = false)
        is HttpResult.Network -> fail(app, "Network error: ${res.message}", retry = true)
        is HttpResult.Status -> when {
            // Same payload would be rejected forever: stop until config change / Sync now.
            res.code == 400 -> fail(app, "Rejected by server (400): ${res.message}", retry = false)
            res.code == 401 -> fail(app, "Unauthorized (check API key)", retry = true)
            else -> fail(app, "Server error ${res.code}: ${res.message}", retry = true)
        }
    }

    /** retry = exponential backoff; otherwise block automatic syncs. Always returns false. */
    private fun fail(app: Context, error: String, retry: Boolean): Boolean {
        Log.w(TAG, error)
        val editor = state(app).edit().putString(KEY_LAST_ERROR, error)
        if (retry) {
            synchronized(lock) {
                backoffMs = if (backoffMs == 0L) BACKOFF_MIN_MS else minOf(backoffMs * 2, BACKOFF_MAX_MS)
                retryAt = System.currentTimeMillis() + backoffMs
            }
        } else {
            editor.putBoolean(KEY_BLOCKED, true)
        }
        editor.apply()
        return false
    }

    private fun status(app: Context): Map<String, Any?> {
        val (rides, points) = try {
            TrackerDb.get(app).pendingCounts()
        } catch (e: Exception) {
            Log.e(TAG, "count failed", e)
            0 to 0
        }
        val s = state(app)
        val lastSyncAt = s.getLong(KEY_LAST_SYNC_AT, 0L)
        return mapOf(
            "enabled" to SyncConfig.load(app).enabled,
            "deviceId" to SyncConfig.deviceId(app),
            "pendingRides" to rides,
            "pendingPoints" to points,
            "lastSyncAt" to (if (lastSyncAt > 0) lastSyncAt else null),
            "lastError" to s.getString(KEY_LAST_ERROR, null),
            "isSyncing" to isSyncing,
        )
    }

    private fun state(context: Context) =
        context.applicationContext.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    // --- HTTP (HttpURLConnection + org.json only) ---

    private sealed class HttpResult {
        object Ok : HttpResult()
        class Status(val code: Int, val message: String) : HttpResult()
        class Network(val message: String) : HttpResult()
        class BadUrl(val message: String) : HttpResult()
    }

    private fun send(method: String, url: String, body: JSONObject, apiKey: String): HttpResult {
        val u = try {
            URL(url)
        } catch (e: MalformedURLException) {
            return HttpResult.BadUrl(url)
        }
        if (u.protocol != "http" && u.protocol != "https") return HttpResult.BadUrl(url)

        var conn: HttpURLConnection? = null
        return try {
            val c = u.openConnection() as HttpURLConnection
            conn = c
            c.requestMethod = method
            c.connectTimeout = CONNECT_TIMEOUT_MS
            c.readTimeout = READ_TIMEOUT_MS
            c.useCaches = false
            c.doOutput = true
            c.setRequestProperty("Content-Type", "application/json; charset=utf-8")
            c.setRequestProperty("Accept", "application/json")
            if (apiKey.isNotEmpty()) c.setRequestProperty("X-Api-Key", apiKey)
            val bytes = body.toString().toByteArray(Charsets.UTF_8)
            c.setFixedLengthStreamingMode(bytes.size)
            c.outputStream.use { it.write(bytes) }

            val code = c.responseCode
            if (code in 200..299) {
                c.inputStream.use { it.readBytes() } // drain so the connection can be reused
                HttpResult.Ok
            } else {
                val text = c.errorStream?.use { it.readBytes().toString(Charsets.UTF_8) } ?: ""
                HttpResult.Status(code, serverMessage(text))
            }
        } catch (e: HttpRetryException) {
            // Thrown instead of a 401 when the body was streamed and the server sent an auth challenge.
            HttpResult.Status(e.responseCode(), e.message ?: "")
        } catch (e: IOException) {
            // No network, DNS, timeout, refused, cleartext not permitted (release builds) ...
            HttpResult.Network(e.message ?: e.javaClass.simpleName)
        } finally {
            conn?.disconnect()
        }
    }

    /** `{ "success": false, "message": "..." }` -> message; otherwise a short raw snippet. */
    private fun serverMessage(text: String): String =
        try {
            JSONObject(text).optString("message").ifEmpty { text.take(200) }
        } catch (_: Exception) {
            text.take(200)
        }

    /** JSON field names/types per docs/SYNC_API.md: epoch ms, real booleans, null (not 0) for missing. */
    private fun TrackPoint.toJson(): JSONObject = JSONObject()
        .put("id", id)
        .put("rideId", rideId)
        .put("lat", lat)
        .put("lng", lng)
        .put("accuracy", accuracy ?: JSONObject.NULL)
        .put("altitude", altitude ?: JSONObject.NULL)
        .put("speed", speed ?: JSONObject.NULL)
        .put("bearing", bearing ?: JSONObject.NULL)
        .put("provider", provider ?: JSONObject.NULL)
        .put("isMocked", isMocked)
        .put("isFiltered", isFiltered)
        .put("filterReason", filterReason ?: JSONObject.NULL)
        .put("recordedAt", recordedAt)
}
