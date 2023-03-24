import UIKit

class PortraitViewController: UIViewController {
    override var shouldAutorotate: Bool {
            return false
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            
           
    return .portrait
        }
    
}
