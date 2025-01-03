import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let eventChannel = FlutterEventChannel(name: "com.kotlincodes.event_channel_demo/stream",
                                               binaryMessenger: controller.binaryMessenger)

        eventChannel.setStreamHandler(EventStreamHandler())

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

class EventStreamHandler: NSObject, FlutterStreamHandler {
    private var timer: Timer?
    private var counter = 0

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.counter += 1
            events("Event: \(self.counter)")
        }
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        timer?.invalidate()
        timer = nil
        return nil
    }
}
