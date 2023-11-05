package br.com.raphaelmaracaipe.portfolio_flutter.security

import br.com.raphaelmaracaipe.portfolio_flutter.consts.CHANNEL_SECURITY
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class ChannelSecurity {

    private lateinit var methodChannel: MethodChannel

    fun initChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_SECURITY
        )
    }

    fun methodHandler() {
        methodChannel.setMethodCallHandler { call, result ->
            when {
                call.method.equals("encrypt") -> {
                    val data = call.argument<String>("data")
                    val key = call.argument<String>("key")
                    val iv = call.argument<String>("iv")
                    val cipher = CryptoHelper.encrypt(data, key, iv)
                    result.success(cipher)
                }
                call.method.equals("decrypt") -> {
                    val data = call.argument<String>("data")
                    val key = call.argument<String>("key")
                    val iv = call.argument<String>("iv")
                    val jsonString = CryptoHelper.decrypt(data, key, iv)
                    result.success(jsonString)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}