package br.com.raphaelmaracaipe.portfolio_flutter

import android.os.Bundle
import br.com.raphaelmaracaipe.portfolio_flutter.regex.ChannelRegex
import br.com.raphaelmaracaipe.portfolio_flutter.security.ChannelSecurity
import br.com.raphaelmaracaipe.portfolio_flutter.security.CryptoHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val channelSecurity = ChannelSecurity()
    private val channelRegex = ChannelRegex()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        channelSecurity.initChannel(flutterEngine)
        channelRegex.initChannel(flutterEngine)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        channelSecurity.methodHandler()
        channelRegex.methodHandler()

    }

}