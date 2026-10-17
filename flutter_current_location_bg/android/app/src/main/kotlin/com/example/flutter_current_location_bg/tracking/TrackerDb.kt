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
        createSyncIndex(db)
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) = Unit

    override fun onOpen(db: SQLiteDatabase) {
        // Also for DB files created before sync existed (no version bump needed).
        if (!db.isReadOnly) createSyncIndex(db)
    }

    /** Partial index: only unsynced points are in it, so it stays tiny. */
    private fun createSyncIndex(db: SQLiteDatabase) {
        db.execSQL("CREATE INDEX IF NOT EXISTS idx_points_unsynced ON points(recorded_at) WHERE synced = 0")
    }

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
            put("synced", 0) // the "ended" status must be uploaded again
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

    // --- Sync (only SyncManager calls these; points stay immutable except `synced`) ---

    fun pendingRides(): List<PendingRide> =
        readableDatabase.rawQuery(
            "SELECT id, started_at, ended_at, status FROM rides WHERE synced = 0 ORDER BY started_at",
            null
        ).use { c ->
            buildList {
                while (c.moveToNext()) {
                    add(PendingRide(c.getString(0), c.getLong(1), if (c.isNull(2)) null else c.getLong(2), c.getString(3)))
                }
            }
        }

    /**
     * Marks the ride synced only if it still has the values that were uploaded,
     * so an endRide() that raced with the upload is sent on the next pass.
     */
    fun markRideSynced(r: PendingRide) {
        writableDatabase.compileStatement(
            "UPDATE rides SET synced = 1 WHERE id = ? AND status = ? AND ended_at IS ?"
        ).use { st ->
            st.bindString(1, r.id)
            st.bindString(2, r.status)
            if (r.endedAt == null) st.bindNull(3) else st.bindLong(3, r.endedAt)
            st.executeUpdateDelete()
        }
    }

    /** Oldest unsynced points first (uses idx_points_unsynced). */
    fun pendingPoints(limit: Int): List<TrackPoint> =
        readableDatabase.rawQuery(
            "SELECT id, ride_id, lat, lng, accuracy, altitude, speed, bearing, provider, " +
                "is_mocked, is_filtered, filter_reason, recorded_at FROM points " +
                "WHERE synced = 0 ORDER BY recorded_at LIMIT $limit",
            null
        ).use { c ->
            fun dbl(i: Int) = if (c.isNull(i)) null else c.getDouble(i)
            fun str(i: Int) = if (c.isNull(i)) null else c.getString(i)
            buildList {
                while (c.moveToNext()) {
                    add(
                        TrackPoint(
                            id = c.getString(0),
                            rideId = c.getString(1),
                            lat = c.getDouble(2),
                            lng = c.getDouble(3),
                            accuracy = dbl(4),
                            altitude = dbl(5),
                            speed = dbl(6),
                            bearing = dbl(7),
                            provider = str(8),
                            isMocked = c.getInt(9) != 0,
                            isFiltered = c.getInt(10) != 0,
                            filterReason = str(11),
                            recordedAt = c.getLong(12),
                        )
                    )
                }
            }
        }

    /** One transaction for the whole batch (ids.size <= 500, below SQLite's 999 variable limit). */
    fun markPointsSynced(ids: List<String>) {
        if (ids.isEmpty()) return
        val db = writableDatabase
        db.beginTransaction()
        try {
            val marks = ids.joinToString(",") { "?" }
            db.execSQL("UPDATE points SET synced = 1 WHERE id IN ($marks)", ids.toTypedArray())
            db.setTransactionSuccessful()
        } finally {
            db.endTransaction()
        }
    }

    /** (pending rides, pending points). */
    fun pendingCounts(): Pair<Int, Int> {
        val db = readableDatabase
        val rides = db.rawQuery("SELECT COUNT(*) FROM rides WHERE synced = 0", null)
            .use { c -> if (c.moveToFirst()) c.getInt(0) else 0 }
        val points = db.rawQuery("SELECT COUNT(*) FROM points WHERE synced = 0", null)
            .use { c -> if (c.moveToFirst()) c.getInt(0) else 0 }
        return rides to points
    }
}

data class PendingRide(val id: String, val startedAt: Long, val endedAt: Long?, val status: String)

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
