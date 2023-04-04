import UIKit
import FirebaseCore
import OneSignal
import AppsFlyerLib
import AppTrackingTransparency
import AdSupport

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
        
        AppsFlyerLib.shared().appsFlyerDevKey = "8aLpiU4bwb6veyvUduxrfN"
        AppsFlyerLib.shared().appleAppID = "6446814935"
        AppsFlyerLib.shared().delegate = self
        
        FirebaseApp.configure()
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId("eb6b528e-9a45-4e15-b785-fb4082f27489")
        
        
        self.requestIDFA {
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                UserDefaults.standard.set(idfa, forKey: "idfa")
                AppsFlyerLib.shared().start()
            })
        }
        
        
        IAPManager.shared.setupPurchases { success in
            if success {
                print("can make paymans")
                IAPManager.shared.getProducts()
            }else{
                print("can't  make paymans")
            }
        }
        return true
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
        if let is_first_launch = data["is_first_launch"] as? Bool, is_first_launch {
            if let status = data["af_status"] as? String {
                if (status == "Non-organic") {
                    if let campaign = data["campaign"] {
                        let userID = AppsFlyerLib.shared().getAppsFlyerUID()
                        UserDefaults.standard.set(userID, forKey: "userID")
                        UserDefaults.standard.set(campaign, forKey: "campaign")
                    }
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadNext"), object: nil)
    }
    
    func onConversionDataFail(_ error: Error) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "loadNext"), object: nil)
    }
}
