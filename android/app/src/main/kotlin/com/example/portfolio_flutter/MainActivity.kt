package com.example.portfolio_flutter

import android.os.Bundle
import com.example.portfolio_flutter.security.CryptoHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.portfolio_flutter/encdesc";

    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        channel.setMethodCallHandler { call, result ->
            if (call.method.equals("encrypt")) {
                val data = call.argument<String>("data")
                val key = call.argument<String>("key")
                val iv = call.argument<String>("iv")
                val cipher = CryptoHelper.encrypt(data, key, iv)
                result.success(cipher)
            } else if (call.method.equals("decrypt")) {
                val data = call.argument<String>("data")
                val key = call.argument<String>("key")
                val iv = call.argument<String>("iv")
                val jsonString = CryptoHelper.decrypt(data, key, iv)
                result.success(jsonString)
            } else {
                result.notImplemented()
            }
        }
    }

}