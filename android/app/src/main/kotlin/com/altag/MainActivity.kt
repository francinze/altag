package com.altag

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.appwidget.AppWidgetManager
import com.altag.MyAppWidgetProvider
import com.altag.R

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.altag/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                updateWidget()
                result.success("Widget updated")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun updateWidget() {
        val intent = Intent(this, MyAppWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        }
        sendBroadcast(intent)
    }
}