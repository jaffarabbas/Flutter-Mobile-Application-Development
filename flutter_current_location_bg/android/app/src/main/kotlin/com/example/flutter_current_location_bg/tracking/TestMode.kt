package com.example.flutter_current_location_bg.tracking

import android.content.Context
import android.content.pm.ApplicationInfo

/**
 * Desk-testing switches. Only honored in debuggable builds, so a release
 * build always rejects mock locations no matter what is stored.
 */
object TestMode {
    private const val PREFS = "tracker_test"
    private const val KEY_ALLOW_MOCK = "allow_mock"

    fun isDebugBuild(context: Context): Boolean =
        (context.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0

    fun allowMock(context: Context): Boolean =
        isDebugBuild(context) &&
            context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getBoolean(KEY_ALLOW_MOCK, false)

    fun setAllowMock(context: Context, allow: Boolean) {
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).edit()
            .putBoolean(KEY_ALLOW_MOCK, allow && isDebugBuild(context))
            .apply()
    }
}
