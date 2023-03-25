import UIKit

class BlurLoader: UIView {
    
    var blurEffectView: UIVisualEffectView?
    
    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addRect()
        addLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addRect() {
        guard let blurEffectView = blurEffectView else { return }
        let rect = UIView()
        rect.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        rect.backgroundColor = .white
        rect.layer.cornerRadius = 15
        rect.alpha = 0.4
        blurEffectView.contentView.addSubview(rect)
        rect.center = blurEffectView.contentView.center
    }
    
    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.style = .gray
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
