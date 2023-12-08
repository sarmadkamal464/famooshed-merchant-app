import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAyj8XQ2neCkrJ-7yQ2UtXXCVz4-MaFMik")
//     GMSServices.provideAPIKey("AIzaSyDwCk9_0qlbcjAxeqTOv2LU2RER9InKcFo")
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
//     GMSServices.provideAPIKey("AIzaSyCFhoAu8rVKv_Kv6KU78W4bhiNPKBIFMz0")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
