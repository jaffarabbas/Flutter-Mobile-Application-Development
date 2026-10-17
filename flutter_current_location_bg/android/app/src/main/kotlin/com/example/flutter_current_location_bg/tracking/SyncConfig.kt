package com.example.flutter_current_location_bg.tracking

import android.content.Context
import java.util.UUID

/**
 * Server sync settings, stored natively so the service can sync without Flutter.
 * Keep keys/behavior in sync with ios/Runner/SyncManager.swift (SyncConfig).
 */
data class SyncConfig(val baseUrl: String, val apiKey: String, val enabled: Boolean) {

    val isUsable: Boolean get() = enabled && baseUrl.isNotEmpty()

    companion object {
        private const val PREFS = "tracker_sync"
        private const val KEY_BASE_URL = "base_url"
        private const val KEY_API_KEY = "api_key"
        private const val KEY_ENABLED = "enabled"
        private const val KEY_DEVICE_ID = "device_id"

        fun load(context: Context): SyncConfig {
            val p = prefs(context)
            return SyncConfig(
                baseUrl = p.getString(KEY_BASE_URL, "") ?: "",
                apiKey = p.getString(KEY_API_KEY, "") ?: "",
                enabled = p.getBoolean(KEY_ENABLED, false),
            )
        }

        /** Trims and strips trailing slashes so paths can be appended directly. */
        fun save(context: Context, baseUrl: String, apiKey: String, enabled: Boolean): SyncConfig {
            val c = SyncConfig(baseUrl.trim().trimEnd('/'), apiKey.trim(), enabled)
            prefs(context).edit()
                .putString(KEY_BASE_URL, c.baseUrl)
                .putString(KEY_API_KEY, c.apiKey)
                .putBoolean(KEY_ENABLED, c.enabled)
                .commit()
            return c
        }

        /** Generated once on first use, never changes (survives app updates, not uninstall). */
        @Synchronized
        fun deviceId(context: Context): String {
            val p = prefs(context)
            p.getString(KEY_DEVICE_ID, null)?.let { return it }
            val id = UUID.randomUUID().toString()
            p.edit().putString(KEY_DEVICE_ID, id).commit()
            return id
        }

        private fun prefs(context: Context) =
            context.applicationContext.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
    }
}
