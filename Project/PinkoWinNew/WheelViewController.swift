import UIKit
import SpriteKit
import GameplayKit

class WheelViewController: PortraitViewController {
    
 
    @IBOutlet weak var wheelImage: UIImageView!
    
    @IBOutlet weak var spinButton: UIButton!
    var nRouletteCount = 8
    var startDegree = 0
    var endDegree = 0
    var divDegree = 0
    var repeatDegree = 360

    var balance: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinButton.layer.cornerRadius = 20
        if UserDefaults.standard.value(forKey: "balance") == nil{
            balance = 0
        }else {
            balance = UserDefaults.standard.integer(forKey: "balance")
        }
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(img1Tapped))
        wheelImage.addGestureRecognizer(tapGesture1)
        wheelImage.isUserInteractionEnabled = true
    }
    

    @IBAction func spinButtonClicked(_ sender: UIButton) {
        img1Tapped()
        
    }
    @objc func img1Tapped() {

        startDegree = divDegree
        let degree_rand = Int.random(in: 0..<360)
        endDegree = startDegree + 360 * nRouletteCount + degree_rand
        divDegree = endDegree % 360
        var bonusCoin = 0

        
        let nResult = getResult(angle: divDegree)
        switch nResult {
        case 1:
            repeatDegree = 360
            bonusCoin = 100
        case 2:
            repeatDegree = 315
            bonusCoin = 10
        case 3:
            repeatDegree = 270
            bonusCoin = 20
        case 4:
            repeatDegree = 225
            bonusCoin = 30
        case 5:
            repeatDegree = 180
            bonusCoin = 50
        case 6:
            repeatDegree = 135
            bonusCoin = 10
        case 7:
            repeatDegree = 90
            bonusCoin = 20
        case 8:
            repeatDegree = 45
            bonusCoin = 40
        default:
            repeatDegree = 360
        }
        balance += bonusCoin
        UserDefaults.standard.set(balance, forKey: "balance")
        UIView.animate(withDuration: 2, delay:0, options:[.curveLinear],  animations: {
            
            for _ in 0..<10{
                self.wheelImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 1))
                self.wheelImage.transform = CGAffineTransform(rotationAngle: 0)
            }
            
        }) { (completed) in
            
            self.wheelImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double((self.repeatDegree)) * Double.pi)/180.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showAlert(delegate: self, titleText: "GIFT BOX", subTitle: "Get \(bonusCoin) gold as a gift", image: UIImage(named: "gold")!)
            }
        }
        
       
    }

    private func getResult(angle : Int) -> Int {
        
        var nResult = 0
        if ( angle > 0 && angle <= 45) {
            nResult = 1//100
        }else if (angle > 45 && angle <= 90){
            nResult = 2//10
        }else if (angle > 90 && angle <= 135){
            nResult = 3//20
        }else if (angle > 135 && angle <= 180){
            nResult = 4//30
        }else if (angle > 180 && angle <= 225){
            nResult = 5//50
        }else if (angle > 225 && angle <= 270){
            nResult = 6//10
        }else if (angle > 270 && angle <= 315){
            nResult = 7//20
        }else if (angle > 315 && angle <= 360){
            nResult = 8//40
        }
        return nResult
    }
    
}

extension WheelViewController: AlertDelegate {
    func okAction() {
        animateOut()
        dismiss(animated: true)
    }
}
