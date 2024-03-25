import UIKit
//import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      ChannelRegex.register(with: registrar(forPlugin: Channel.encdesc)!)
      ChannelSecurity.register(with: registrar(forPlugin: Channel.regex)!)
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
