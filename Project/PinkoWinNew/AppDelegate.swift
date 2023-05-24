import UIKit
import FirebaseCore
import OneSignal
import AppsFlyerLib
import AppTrackingTransparency
import AdSupport
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    var application: UIApplication?
    
    func requestIDFA(completion: @escaping ()->()) {
        if #available(iOS 14.5, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                ATTrackingManager.requestTrackingAuthorization { status in
                    completion()
                }
            })
        } else {
            completion()
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.launchOptions = launchOptions
        self.application = application
        
        AppsFlyerLib.shared().appsFlyerDevKey = "8HLhJCx26dDN9nTd6Q75XE"
        AppsFlyerLib.shared().appleAppID = "6446814935"
        
        FirebaseApp.configure()
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("eb6b528e-9a45-4e15-b785-fb4082f27489")
        
        self.requestIDFA {
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                let userID = AppsFlyerLib.shared().getAppsFlyerUID()
                UserDefaults.standard.set(idfa, forKey: "idfa")
                UserDefaults.standard.set(userID, forKey: "userID")
                ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
                AppsFlyerLib.shared().start()
            })
        }
        
        
        IAPManager.shared.setupPurchases { success in
            if success {
                IAPManager.shared.getProducts()
            }
        }
        return true
    }
}
