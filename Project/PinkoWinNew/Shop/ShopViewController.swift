import UIKit
import Firebase
class ShopViewController: PortraitViewController {

    @IBOutlet weak var backgroundShopView: UIView!
 
    @IBOutlet weak var buttonMenuBackground: UIView!
    @IBOutlet var skinsImage: [UIImageView]!
    @IBOutlet var skinButtons: [UIButton]!
    
    private var selectedSkin = 1
    private var purchasedSkin: [Int]!
    private var balance: Int!
    private var sounds:Bool!
    private var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let sounds = UserDefaults.standard.object(forKey: "sounds") as? Bool{
            self.sounds = sounds
        }else{
            self.sounds = true
        }
        
        if let currentUser = Auth.auth().currentUser  {
            ref = Database.database().reference(withPath: "users").child(currentUser.uid)
        }
        
        if  UserDefaults.standard.value(forKey: "purchasedSkin") == nil{
            let skin = [1]
            UserDefaults.standard.set(skin, forKey: "purchasedSkin")
            UserDefaults.standard.synchronize()
            
        }
        
        purchasedSkin = UserDefaults.standard.array(forKey: "purchasedSkin") as? [Int]
        if let skin = UserDefaults.standard.value(forKey: "skin") as? Int{
            selectedSkin = skin
        }
        
        balance = UserDefaults.standard.integer(forKey: "balance")
        setupViews()
        updateButtonTitles()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.child("balance").observe(.value) { [weak self] snapshot,_   in
            if let coins = snapshot.value as? Int {
                self?.balance = coins
                self?.updateButtonTitles()
            }
        }
    }
    private func setupViews() {
            backgroundShopView.layer.cornerRadius = 20
            buttonMenuBackground.layer.cornerRadius = 10
            
            for skinView in skinsImage {
                skinView.layer.cornerRadius = 20
            }
            
            for button in skinButtons {
                button.layer.cornerRadius = 10
            }
            
            updateButtonTitles()
        }
    
    
    private func updateButtonTitles(){
       
        
        for (index, button) in skinButtons.enumerated() {
            if purchasedSkin.contains(index + 1) {
                if index == selectedSkin - 1 {
                    button.setTitle("Selected", for: .normal)
                }else{
                    button.setTitle("Select", for: .normal)
                }
            }else {
                button.setTitle("1000", for: .normal)
            }
            button.layer.cornerRadius = 10
        }
    }
    
    
    
    @IBAction func skinButtonClicked(_ sender: UIButton) {
        SoundManager.shared.buttonSound(selector: sounds)
        if sender.titleLabel?.text! == "1000" && balance >= 1000{
            let index = sender.tag + 1
            purchasedSkin.append(index)
            ShoppingManager.shared.purchasedSkin(team: index)
            balance -= 1000
            UserDefaults.standard.set(balance, forKey: "balance")
            
        }else if sender.titleLabel?.text! == "Select" {
            sender.titleLabel?.text = "Selected"
            selectedSkin = sender.tag + 1
            UserDefaults.standard.set(selectedSkin, forKey: "skin")
        }else if balance < 1000 {
            self.showAlert(delegate: self, titleText: "Sorry", subTitle: "You don't have enough gold", image: UIImage(named: "gold")!)
        }
        updateButtonTitles()
        
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        SoundManager.shared.buttonSound(selector: sounds)
        UserDefaults.standard.set(balance, forKey: "coins")
        FirebaseManager.shared.saveGold(gold: balance)
        
        saveSkin(skin: selectedSkin)
        dismiss(animated: true)
    }
    
    func saveSkin(skin: Int){
        let ref = ref.child("skin")
        ref.removeValue()
        ref.setValue(skin)
    }
    
}

extension ShopViewController: AlertDelegate {
    func okAction() {
        animateOut()
    }
}

