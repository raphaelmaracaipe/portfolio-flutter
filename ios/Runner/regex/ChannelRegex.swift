import Flutter
import UIKit

public class ChannelRegex: NSObject, FlutterPlugin {
    
    private let regex = Regex()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: Channel.regex, binaryMessenger: registrar.messenger())
        let instance = ChannelRegex()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "regex" {
            let args = call.arguments as? [String: Any]
            let pattern = args?["pattern"] as? String
            if(pattern?.isEmpty ?? false) {
                result(FlutterMethodNotImplemented)
                return
            }
            
            result(regex.generate(pattern: pattern!))
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
}
