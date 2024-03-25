import Flutter
import UIKit

public class ChannelSecurity: NSObject, FlutterPlugin {
    
    private let crypto = CryptoHelper()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: Channel.encdesc, binaryMessenger: registrar.messenger())
        let instance = ChannelSecurity()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any]
        let data = args?["data"] as? String ?? ""
        let key = args?["key"] as? String ?? ""
        let iv = args?["iv"] as? String ?? ""
        
        if(data.isEmpty || key.isEmpty || iv.isEmpty ) {
            result("")
            return
        }
        
        if call.method == "encrypt" {
            guard let textEncryptedData = try? crypto.encrypt(text: data, key: key, iv: iv) else {
                result("")
                return
            }
            
            result(textEncryptedData)
        } else if call.method == "decrypt" {
            guard let textDecrypted = try? crypto.descrypt(encryptedText: data, key: key, iv: iv) else {
                result("")
                return
            }
            
            result(textDecrypted)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
}
