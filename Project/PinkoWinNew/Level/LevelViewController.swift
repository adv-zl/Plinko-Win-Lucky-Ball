import UIKit

class LevelViewController: PortraitViewController {
    
    @IBOutlet weak var levelTableView: UITableView!
    
    @IBOutlet weak var balancelabel: UILabel!
    var openLevel = 0
    var selectedLvl = 0
    var balance = 0
    private lazy var sounds: Bool = {
        return UserDefaults.standard.object(forKey: "sounds") as? Bool ?? true
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let balance = UserDefaults.standard.value(forKey: "balance") as? Int{
            self.balance = balance
        }else{
            self.balance = 0
            UserDefaults.standard.set(self.balance, forKey: "balance")
        }
        
        balancelabel.text = "\(balance)"
        
        if let openLvl = UserDefaults.standard.value(forKey: "openLvl") as? Int{
            self.openLevel = openLvl
        }else{
            self.openLevel = 1
            UserDefaults.standard.set(self.openLevel, forKey: "openLvl")
        }
        
        if let selectedLvl = UserDefaults.standard.value(forKey: "selectedLvl") as? Int{
            self.selectedLvl = selectedLvl
        }else{
            self.selectedLvl = 1
            UserDefaults.standard.set(self.selectedLvl, forKey: "selectedLvl")
        }
        
        
    }
    
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        SoundManager.shared.buttonSound(selector: sounds)
        dismiss(animated: true)
    }
    
    
}


extension LevelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LevelCell
        cell.levelLabel.text = "LEVEL \(indexPath.row + 1)"
        cell.imageLvlView.image = UIImage(named: "ball\(indexPath.row+1)")
        
        if openLevel >= indexPath.row + 1 {
            if selectedLvl == indexPath.row + 1{
                cell.costLabel.text = "SELECTED"
                cell.costLabel.font = UIFont.systemFont(ofSize: 20) // установить размер шрифта 16
            }else{
                cell.costLabel.text = "CHOOSE"
                cell.costLabel.font = UIFont.systemFont(ofSize: 20)
            }
        }else{
            cell.costLabel.text = "\(50 + (indexPath.row * 50))"
        }
        
        if openLevel >= (indexPath.row + 1) {
            cell.selectImageView.isHidden = true
        }else{
            cell.selectImageView.image = UIImage(named: "lock")
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if openLevel >= (indexPath.row + 1){
            let selectLevel = (indexPath.row + 1)
            UserDefaults.standard.set(selectLevel, forKey: "selectedLvl")
            SoundManager.shared.buttonSound(selector: sounds)
            performSegue(withIdentifier: "gameVC", sender: self)
            
        }else {
            if openLevel + 1 == indexPath.row + 1 {
                if balance >= (50 + (indexPath.row * 50)){
                    let selectLevel = (indexPath.row + 1)
                    UserDefaults.standard.set(selectLevel, forKey: "selectedLvl")
                    UserDefaults.standard.set(selectLevel, forKey: "openLvl")
                    balance -= 50 + (indexPath.row * 50)
                    FirebaseManager.shared.saveGold(gold: balance)
                    UserDefaults.standard.set(balance, forKey: "balance")
                    performSegue(withIdentifier: "gameVC", sender: self)
                }else{
                    self.showAlert(delegate: self, titleText: "Need more gold", subTitle: "You need \(50 + (indexPath.row * 50)) gold to buy this level", image: UIImage(named: "gold")!)
                }
            }else{
                self.showAlert(delegate: self, titleText: "Not so fast", subTitle: "You need to buy previous levels", image: UIImage(named: "lock")!)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension LevelViewController: AlertDelegate {
    func okAction() {
        animateOut()
    }
}
