package com.example.flutter_current_location_bg.tracking

import kotlin.math.asin
import kotlin.math.cos
import kotlin.math.max
import kotlin.math.pow
import kotlin.math.sin
import kotlin.math.sqrt

/** Tunable thresholds. Keep in sync with ios/Runner/PointFilter.swift. */
object FilterConfig {
    /** Reject fixes whose reported horizontal accuracy is worse than this. */
    const val MAX_ACCURACY_M = 20.0

    /** Reject fixes implying a faster move than this from the last good point. */
    const val MAX_SPEED_MPS = 55.0

    /** Below this reported speed the device is treated as standing still (GPS drift). */
    const val STATIONARY_SPEED_MPS = 0.5

    /** A move smaller than the fix's own accuracy is noise. Never use less than this floor. */
    const val MIN_MOVE_M = 3.0

    /**
     * At or above this reported (Doppler) speed the device is really moving, so the
     * jitter check is skipped: at ~3 m/s with ~10 m accuracy it would reject 2 of 3 real fixes.
     */
    const val MOVING_SPEED_MPS = 1.5
}

/**
 * Flags (never drops) suspicious fixes. Every distance check is measured
 * against the last point that passed the filter.
 *
 * Order: mocked -> low_accuracy -> speed_jump -> stationary -> jitter
 */
class PointFilter {
    var lastGood: GoodFix? = null

    /** Debug builds only (see TestMode): mocked points are still stored with is_mocked = 1. */
    var allowMock = false

    /** Returns the filter reason, or null if the point is good. */
    fun evaluate(
        lat: Double,
        lng: Double,
        accuracy: Double?,
        speed: Double?,
        isMocked: Boolean,
        recordedAt: Long,
    ): String? {
        val prev = lastGood
        val dist = if (prev == null) 0.0 else haversine(prev.lat, prev.lng, lat, lng)

        val reason = when {
            isMocked && !allowMock -> "mocked"
            accuracy == null || accuracy > FilterConfig.MAX_ACCURACY_M -> "low_accuracy"
            prev != null && impliedSpeed(prev, dist, recordedAt) > FilterConfig.MAX_SPEED_MPS -> "speed_jump"
            // The first good point of a ride is always accepted so the route has an anchor.
            prev != null && speed != null && speed < FilterConfig.STATIONARY_SPEED_MPS -> "stationary"
            prev != null && (speed == null || speed < FilterConfig.MOVING_SPEED_MPS) &&
                dist < max(accuracy, FilterConfig.MIN_MOVE_M) -> "jitter"
            else -> null
        }
        if (reason == null) lastGood = GoodFix(lat, lng, recordedAt)
        return reason
    }

    private fun impliedSpeed(prev: GoodFix, dist: Double, recordedAt: Long): Double {
        val dtSec = (recordedAt - prev.recordedAt) / 1000.0
        // Same/backwards timestamp: any real movement is impossible.
        if (dtSec <= 0) return if (dist > 1.0) Double.MAX_VALUE else 0.0
        return dist / dtSec
    }

    companion object {
        fun haversine(lat1: Double, lng1: Double, lat2: Double, lng2: Double): Double {
            val r = 6371000.0
            val dLat = Math.toRadians(lat2 - lat1)
            val dLng = Math.toRadians(lng2 - lng1)
            val a = sin(dLat / 2).pow(2) +
                cos(Math.toRadians(lat1)) * cos(Math.toRadians(lat2)) * sin(dLng / 2).pow(2)
            return 2 * r * asin(sqrt(a))
        }
    }
}
