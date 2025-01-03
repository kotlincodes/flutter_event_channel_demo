package com.kotlincodes.event_channel_demo

import android.os.Handler
import android.os.Looper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.kotlincodes.event_channel_demo/stream"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            private var handler: Handler? = null
            private var runnable: Runnable? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                handler = Handler(Looper.getMainLooper())
                runnable = object : Runnable {
                    private var counter = 0
                    override fun run() {
                        events?.success("Event: ${++counter}")
                        handler?.postDelayed(this, 1000) // Send data every second
                    }
                }
                handler?.post(runnable!!)
            }

            override fun onCancel(arguments: Any?) {
                handler?.removeCallbacks(runnable!!)
            }
        })
    }
}
 