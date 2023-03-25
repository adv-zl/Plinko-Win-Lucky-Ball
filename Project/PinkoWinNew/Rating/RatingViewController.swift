import UIKit
import Firebase
import FirebaseDatabase

class RatingViewController: PortraitViewController {

    @IBOutlet weak var ratingTableView: UITableView!
    
    private var ref: DatabaseReference!
    private var users = [User]()
    
    private lazy var sounds: Bool = {
        return UserDefaults.standard.object(forKey: "sounds") as? Bool ?? true
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(withPath: "users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    private func fetchData() {
        ref.observe(.value) { [weak self] snapshot,_  in
            guard let self = self else { return }
            
            self.users.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let user = User(snapshot: child){
                    self.users.append(user)
                }
            }
            self.users.sort(by: { $0.gold! > $1.gold! })
            self.ratingTableView.reloadData()
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
        SoundManager.shared.buttonSound(selector: sounds)
    }
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RatingCell

        let user = users[indexPath.row]
        cell.selectionStyle = .none
        cell.playerNameLabel.text = user.userName
        cell.goldLabel.text = String(describing: user.gold!)
        if let url = URL(string: user.userAvatar) {
            downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.avatarView.image = image
                    cell.avatarView.layer.cornerRadius = cell.avatarView.frame.height / 2
                }
            }
        }else{
            cell.avatarView.image = UIImage(named: "avatar")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
   
}
