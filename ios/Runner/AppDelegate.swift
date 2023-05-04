import UIKit
import Flutter


private let updateCheckPotDataEventChannel = "checkpot/temperature"


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let rootViewController : CheckPotViewController = window?.rootViewController as! CheckPotViewController
      
      FlutterEventChannel(name: updateCheckPotDataEventChannel, binaryMessenger: rootViewController.binaryMessenger)
          .setStreamHandler(rootViewController)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
