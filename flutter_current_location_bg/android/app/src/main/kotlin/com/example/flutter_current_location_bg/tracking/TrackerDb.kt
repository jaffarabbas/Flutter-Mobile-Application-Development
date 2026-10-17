package com.example.flutter_current_location_bg.tracking

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper

/**
 * Plain SQLite storage shared with Flutter (sqflite opens the same file).
 * Schema must stay identical to ios/Runner/Tracking/TrackerDb.swift.
 */
class TrackerDb private constructor(context: Context) :
    SQLiteOpenHelper(context.applicationContext, DB_NAME, null, DB_VERSION) {

    companion object {
        const val DB_NAME = "tracker.db"
        private const val DB_VERSION = 1

        @Volatile
        private var instance: TrackerDb? = null

        fun get(context: Context): TrackerDb =
            instance ?: synchronized(this) {
                instance ?: TrackerDb(context).also { instance = it }
            }

        fun path(context: Context): String =
            context.applicationContext.getDatabasePath(DB_NAME).absolutePath
    }

    init {
        setWriteAheadLoggingEnabled(true)
    }

    override fun onConfigure(db: SQLiteDatabase) {
        db.setForeignKeyConstraintsEnabled(true)
    }

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(
            """
            CREATE TABLE IF NOT EXISTS rides (
              id TEXT PRIMARY KEY,
              started_at INTEGER NOT NULL,
              ended_at INTEGER,
              status TEXT NOT NULL,
              synced INTEGER NOT NULL DEFAULT 0
            )
            """.trimIndent()
        )
        db.execSQL(
            """
            CREATE TABLE IF NOT EXISTS points (
              id TEXT PRIMARY KEY,
              ride_id TEXT NOT NULL REFERENCES rides(id),
              lat REAL NOT NULL,
              lng REAL NOT NULL,
              accuracy REAL,
              altitude REAL,
              speed REAL,
              bearing REAL,
              provider TEXT,
              is_mocked INTEGER NOT NULL DEFAULT 0,
              is_filtered INTEGER NOT NULL DEFAULT 0,
              filter_reason TEXT,
              recorded_at INTEGER NOT NULL,
              synced INTEGER NOT NULL DEFAULT 0
            )
            """.trimIndent()
        )
        db.execSQL("CREATE INDEX IF NOT EXISTS idx_points_ride ON points(ride_id, recorded_at)")
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) = Unit

    /** Creates the ride row if missing (idempotent so service restarts are safe). */
    fun startRide(rideId: String, startedAt: Long) {
        val values = ContentValues().apply {
            put("id", rideId)
            put("started_at", startedAt)
            put("status", "active")
        }
        writableDatabase.insertWithOnConflict("rides", null, values, SQLiteDatabase.CONFLICT_IGNORE)
    }

    fun endRide(rideId: String, endedAt: Long) {
        val values = ContentValues().apply {
            put("ended_at", endedAt)
            put("status", "ended")
        }
        writableDatabase.update("rides", values, "id = ?", arrayOf(rideId))
    }

    fun insertPoint(p: TrackPoint) {
        val values = ContentValues().apply {
            put("id", p.id)
            put("ride_id", p.rideId)
            put("lat", p.lat)
            put("lng", p.lng)
            put("accuracy", p.accuracy)
            put("altitude", p.altitude)
            put("speed", p.speed)
            put("bearing", p.bearing)
            put("provider", p.provider)
            put("is_mocked", if (p.isMocked) 1 else 0)
            put("is_filtered", if (p.isFiltered) 1 else 0)
            put("filter_reason", p.filterReason)
            put("recorded_at", p.recordedAt)
        }
        writableDatabase.insertWithOnConflict("points", null, values, SQLiteDatabase.CONFLICT_IGNORE)
    }

    /** Last unfiltered point of a ride, used to seed the speed-jump filter after a restart. */
    fun lastGoodPoint(rideId: String): GoodFix? {
        readableDatabase.rawQuery(
            "SELECT lat, lng, recorded_at FROM points WHERE ride_id = ? AND is_filtered = 0 " +
                "ORDER BY recorded_at DESC LIMIT 1",
            arrayOf(rideId)
        ).use { c ->
            return if (c.moveToFirst()) GoodFix(c.getDouble(0), c.getDouble(1), c.getLong(2)) else null
        }
    }
}

data class TrackPoint(
    val id: String,
    val rideId: String,
    val lat: Double,
    val lng: Double,
    val accuracy: Double?,
    val altitude: Double?,
    val speed: Double?,
    val bearing: Double?,
    val provider: String?,
    val isMocked: Boolean,
    val isFiltered: Boolean,
    val filterReason: String?,
    val recordedAt: Long,
) {
    fun toMap(): Map<String, Any?> = mapOf(
        "id" to id,
        "ride_id" to rideId,
        "lat" to lat,
        "lng" to lng,
        "accuracy" to accuracy,
        "altitude" to altitude,
        "speed" to speed,
        "bearing" to bearing,
        "provider" to provider,
        "is_mocked" to if (isMocked) 1 else 0,
        "is_filtered" to if (isFiltered) 1 else 0,
        "filter_reason" to filterReason,
        "recorded_at" to recordedAt,
    )
}

data class GoodFix(val lat: Double, val lng: Double, val recordedAt: Long)
