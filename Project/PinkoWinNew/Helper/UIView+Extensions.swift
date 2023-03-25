import UIKit

extension UIView {
    public func showLoading() {
        let blurLoader = BlurLoader(frame: frame)
        blurLoader.alpha = 0
        self.addSubview(blurLoader)
        UIView.animate(withDuration: 0.3) {
            blurLoader.alpha = 1
        } completion: { _ in
            blurLoader.alpha = 1
        }
    }
    
    public func hideLoading() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            UIView.animate(withDuration: 0.3) {
                blurLoader.alpha = 0
            } completion: { _ in
                blurLoader.removeFromSuperview()
            }
        }
    }
}


extension UIViewController {
    func findGameViewController() -> GameViewController? {
        if let gameViewController = self as? GameViewController {
            return gameViewController
        } else if let parentViewController = self.parent {
            return parentViewController.findGameViewController()
        } else {
            return nil
        }
    }
}
