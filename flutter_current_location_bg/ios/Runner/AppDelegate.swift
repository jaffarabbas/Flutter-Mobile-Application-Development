import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Must run early: on a background relaunch (launchOptions[.location]) iOS
    // only delivers locations to a manager created during launch.
    LocationTracker.shared.resumeIfNeeded()

    GeneratedPluginRegistrant.register(with: self)
    registerTrackerChannels()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func registerTrackerChannels() {
    guard let registrar = registrar(forPlugin: "RideTracker") else { return }
    let messenger = registrar.messenger()
    let tracker = LocationTracker.shared

    FlutterEventChannel(name: "tracker/points", binaryMessenger: messenger)
      .setStreamHandler(tracker)

    FlutterMethodChannel(name: "tracker/control", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        switch call.method {
        case "startRide":
          guard let args = call.arguments as? [String: Any],
                let rideId = args["rideId"] as? String, !rideId.isEmpty else {
            result(FlutterError(code: "ARG", message: "rideId required", details: nil))
            return
          }
          tracker.startRide(rideId)
          result(true)
        case "stopRide":
          tracker.stopRide()
          result(true)
        case "isTracking":
          tracker.resumeIfNeeded()
          let id = tracker.activeRideId
          result(["tracking": id != nil, "rideId": id ?? NSNull()] as [String: Any])
        case "getDbPath":
          result(TrackerDb.shared.path)
        case "getPermissionStatus":
          result(tracker.permissionStatus())
        case "requestPermissions":
          tracker.requestPermissions(result)
        case "openBatteryOptimizationSettings":
          // No battery-optimization screen on iOS; open the app's settings instead.
          if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
          }
          result(true)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
  }
}
