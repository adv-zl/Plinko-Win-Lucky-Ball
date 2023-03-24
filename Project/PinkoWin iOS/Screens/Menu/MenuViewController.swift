import UIKit

class MenuViewController: PortraitViewController {
    
    @IBOutlet var menuButttons: [UIButton]!
    private lazy var sounds: Bool = {
        return UserDefaults.standard.object(forKey: "sounds") as? Bool ?? true
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButttons.forEach { $0.layer.cornerRadius = 20 }
        FirebaseManager.shared.fetchGoldAmount { result in
            switch result {
            case .success(let goldAmount):
                print("User has \(goldAmount) gold")
                FirebaseManager.shared.saveGold(gold: goldAmount)
                UserDefaults.standard.set(goldAmount, forKey: "balance")
                // Делайте что-то с полученным количеством золота
            case .failure(let error):
                print("Failed to fetch gold amount: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        SoundManager.shared.buttonSound(selector: sounds)
    }
    
    
}
