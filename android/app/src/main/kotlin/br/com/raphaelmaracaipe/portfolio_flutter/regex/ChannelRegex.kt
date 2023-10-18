package br.com.raphaelmaracaipe.portfolio_flutter.regex

import br.com.raphaelmaracaipe.portfolio_flutter.consts.CHANNEL_REGEX
import br.com.raphaelmaracaipe.portfolio_flutter.regex.Regex
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class ChannelRegex {

    private lateinit var methodChannel: MethodChannel
    private val regex = Regex()

    fun initChannel(flutterEngine: FlutterEngine) {
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_REGEX
        )
    }

    fun methodHandler() {
        methodChannel.setMethodCallHandler { call, result ->
            when {
                call.method.equals("regex") -> {
                    call.argument<String>("pattern")?.let { pattern ->
                        val regex = regex.generate(pattern)
                        result.success(regex)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

}