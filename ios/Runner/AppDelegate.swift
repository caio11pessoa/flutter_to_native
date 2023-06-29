import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let METHOD_CHANNEL_NAME = "uniquedomain.com/battery"
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let batteryChannel = FlutterMethodChannel(
        name: METHOD_CHANNEL_NAME,
        binaryMessenger: controller.binaryMessenger
      )
      
      batteryChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
//          switch call.method {
//          case "getBatteryLevel":
//              guard let args = call.arguments as? [String: String] else {return}
//              let name = args["name"]!
              guard call.method == "getBatteryLevel" else {
                result(FlutterMethodNotImplemented)
                return
              }
              self?.receiveBatteryLevel(result: result)
              
//              self.receiveBatteryLevel()
//          default:
//              result(FlutterMethodNotImplemented)
//          }
      })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
//
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(Int.random(in: 0...100))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
    
}
