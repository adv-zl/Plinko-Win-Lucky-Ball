import Foundation
import UIKit

protocol AlertDelegate {
    func okAction()
}

class Alert: UIView {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var okOutlet: UIButton!
    @IBAction func okAction(_ sender: Any) {
        delegate?.okAction()
    }
    
    override func layoutSubviews() {
        okOutlet.layer.cornerRadius = 20
    }
    
    var delegate: AlertDelegate?
}

extension UIViewController {
    func showAlert(delegate: AlertDelegate, titleText: String, subTitle: String, image: UIImage?){
        let visualEffectView: UIVisualEffectView = {
            let blurEffect = UIBlurEffect(style: .dark)
            let view = UIVisualEffectView(effect: blurEffect)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        self.view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
        
        guard let alertView = Bundle.main.loadNibNamed("Alert", owner: nil, options: nil)![0] as? Alert else { return }
        alertView.delegate = delegate
        alertView.imageView.image = image
        alertView.titleLabel.text = titleText
        alertView.subTitleLabel.text = subTitle
        alertView.backgroundView.layer.cornerRadius = 20
        alertView.tag = 100
        visualEffectView.tag = 101
        self.view.addSubview(alertView)
        alertView.center = self.view.center
        
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            visualEffectView.alpha = 1
            alertView.alpha = 1
            alertView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        if let alert = self.view.viewWithTag(100), let effect = self.view.viewWithTag(101) {
            UIView.animate(withDuration: 0.3, animations: {
                effect.alpha = 0
                alert.alpha = 0
                alert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            }) { (_) in
                alert.removeFromSuperview()
                effect.removeFromSuperview()
            }
        }
    }
    
}
