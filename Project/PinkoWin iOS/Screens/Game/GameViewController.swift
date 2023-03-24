import UIKit
import SpriteKit
import GameplayKit

class GameViewController: PortraitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: self.view.frame.size)
        scene.viewController = self
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
       
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        setupDefaults()
    }
    func setupDefaults(){
        if let balance = UserDefaults.standard.value(forKey: "balance") as? Int{
            if balance <= 0 {
                self.showAlert(delegate: self, titleText: "GIFT BOX", subTitle: "Get 100 gold as a gift", image: UIImage(named: "box")!)
            }
        }else{
            UserDefaults.standard.set(100, forKey: "balance")
            self.showAlert(delegate: self, titleText: "GIFT BOX", subTitle: "Get 100 gold as a gift", image: UIImage(named: "box")!)
        }
    }

   
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
extension GameViewController: AlertDelegate {
    func okAction() {
        animateOut()
    }
}
