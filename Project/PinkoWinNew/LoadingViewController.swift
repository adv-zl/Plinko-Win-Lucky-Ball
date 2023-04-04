import UIKit
import Firebase
import IonicLiveUpdates
import IonicPortals

class LoadingViewController: PortraitViewController {
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        UIView.animate(withDuration:0.5,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.logo.frame.origin.y -= 10
            
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNext), name:NSNotification.Name(rawValue: "loadNext"), object: nil)
        PortalsRegistrationManager.shared.register(key: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJjMmJjMWNlMS01NTJmLTQ0Y2YtOTM5YS1kYjUwMmVjMTAyMmQifQ.OhqiP3Hguok9yVfUZb06RSQ-K2TVapTdyFwNdMgae13ZMnBggQk4PxODeqHwK6Oz7LSkD_d5OT4XRepAY1NHfbVOWlG83WXMJcqL3uwUPOF0ehkIjJwZZfAdq-xRT-RZZWJus-kuZNAt-f0ANScDXVAoXrporaOEsV15LpeAwyNKKJ_QxlXEuqjukU1aCj1MoTOTnQw0mpaVlLXwm_OAqKaKT05jY5szF54DbQh_BWmYom-IpNMhZHpUxTVAjKBS3_utTy-6PJgOf2d6O85lCsReV7s7Rb1fs2PPX6bMGZ_AjYbH5k6Hr0-J88302OUyprBal_KOo7TBGA8-jE21xw")
        try? LiveUpdateManager.shared.add(.onboarding)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if State.shared.isNotFirstLaunch() {
            continueLoad()
        }
    }
    
    @objc func loadNext() {
        if State.shared.isNotFirstLaunch() {
            continueLoad()
        } else {
            portalOnboarding.initialContext = ["startingRoute": "/onboarding", "paramsString": "?deviceID=\(UserDefaults.standard.value(forKey: "idfa") ?? "")&userID=\(UserDefaults.standard.value(forKey: "userID") ?? "")&campaign=\(UserDefaults.standard.value(forKey: "campaign") ?? "")"]
            LiveUpdateManager.shared.sync(
                isParallel: false,
                syncComplete: {
                    print("Sync completed!")
                    
                },
                appComplete: { _ in
                    print("App update complete")
                    DispatchQueue.main.async {
                        let viewController = OnboardingVC()
                        viewController.modalPresentationStyle = .fullScreen
                        viewController.modalTransitionStyle = .crossDissolve
                        self.present(viewController, animated: true, completion: nil)
                    }
                }
            )
        }
    }
    
    func continueLoad() {
        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil {
                self.view.showLoading()
                let userDefaults = UserDefaults.standard
                        let lastLaunchDate = userDefaults.object(forKey: "lastLaunchDate") as? Date
                        
                        if let lastLaunchDate = lastLaunchDate, Calendar.current.isDateInToday(lastLaunchDate) {
                            // User has launched the app today, go to mainVC
                            self.view.showLoading()
                            self.performSegue(withIdentifier: "mainVC", sender: nil)
                        } else {
                            // User is launching the app for the first time today or after a day has passed, go to bonusVC
                            userDefaults.set(Date(), forKey: "lastLaunchDate")
                            self.view.showLoading()
                            self.performSegue(withIdentifier: "whellVC", sender: nil)
                        }
                    
               // self.performSegue(withIdentifier: "mainVC", sender: nil)
            } else {
                self.view.showLoading()
                Auth.auth().signInAnonymously { authResult, error in
                    if error == nil {
                        let userName = "Player"
                        let avatarImage = UIImage(named: "avatar")!
                        FirebaseManager.shared.saveUser(userName: userName, avatarImage: avatarImage)
                    } else {
                        self.view.hideLoading()
                    }
                }
                self.performSegue(withIdentifier: "whellVC", sender: nil)
                
            }
        }
    }
}

var portalOnboarding = Portal(
    name: "onboarding",
    startDir: "portals/onboarding",
    liveUpdateConfig: .onboarding
)

extension LiveUpdate {
    private static let activeChannel = UserDefaults.standard.string(forKey: "active_channel") ?? "production"
    
    static let onboarding = Self(
        appId: "e858d094",
        channel: activeChannel,
        syncOnAdd: false
    )
}

