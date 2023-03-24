import UIKit
import Firebase
import OneSignal
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
    
        
        PortalsRegistrationManager.shared.register(key: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJjMmJjMWNlMS01NTJmLTQ0Y2YtOTM5YS1kYjUwMmVjMTAyMmQifQ.OhqiP3Hguok9yVfUZb06RSQ-K2TVapTdyFwNdMgae13ZMnBggQk4PxODeqHwK6Oz7LSkD_d5OT4XRepAY1NHfbVOWlG83WXMJcqL3uwUPOF0ehkIjJwZZfAdq-xRT-RZZWJus-kuZNAt-f0ANScDXVAoXrporaOEsV15LpeAwyNKKJ_QxlXEuqjukU1aCj1MoTOTnQw0mpaVlLXwm_OAqKaKT05jY5szF54DbQh_BWmYom-IpNMhZHpUxTVAjKBS3_utTy-6PJgOf2d6O85lCsReV7s7Rb1fs2PPX6bMGZ_AjYbH5k6Hr0-J88302OUyprBal_KOo7TBGA8-jE21xw")
        try? LiveUpdateManager.shared.add(.onboarding)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if State.shared.isNotFirstLaunch() {
            loadNext()
        } else {
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                portalOnboarding.initialContext = ["startingRoute": "/onboarding", "deviceID": OneSignal.getDeviceState().userId ?? String(describing: UIDevice.current.identifierForVendor?.uuidString)]
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
            })
        }
    }

    @objc func loadNext() {
        DispatchQueue.main.async {
     print("LOLO\(Auth.auth().currentUser)")
            if let user = Auth.auth().currentUser {
              
                print("Уже зареган")
                self.view.showLoading()
                
                self.performSegue(withIdentifier: "mainVC", sender: nil)
            } else {
                print("нужно зарегать пользователя")
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
                self.performSegue(withIdentifier: "mainVC", sender: nil)

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
        appId: "80f4d205",
        channel: activeChannel,
        syncOnAdd: false
    )
}

