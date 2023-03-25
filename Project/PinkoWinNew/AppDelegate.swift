import UIKit
import FirebaseCore
import OneSignal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
//        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
//        // OneSignal initialization
//        OneSignal.initWithLaunchOptions(launchOptions)
//        OneSignal.setAppId("488ef2a9-7fbc-4dff-999c-0daa22f76ae8")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

