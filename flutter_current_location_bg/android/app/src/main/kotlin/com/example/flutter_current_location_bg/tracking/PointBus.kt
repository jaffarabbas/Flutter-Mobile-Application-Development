package com.example.flutter_current_location_bg.tracking

import android.os.Handler
import android.os.Looper

/**
 * In-process bridge from LocationService to the Flutter EventChannel.
 * When no Flutter UI is attached the listener is null and points only go to SQLite.
 */
object PointBus {
    private val main = Handler(Looper.getMainLooper())

    @Volatile
    var listener: ((Map<String, Any?>) -> Unit)? = null

    fun publish(point: TrackPoint) {
        if (listener == null) return
        val map = point.toMap()
        main.post { listener?.invoke(map) }
    }
}
