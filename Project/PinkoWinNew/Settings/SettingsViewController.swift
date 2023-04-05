import UIKit
import Firebase
import StoreKit

class SettingsViewController: PortraitViewController {
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet var settinsButton: [UIButton]!
    
    @IBOutlet weak var firstAvatar: UIImageView!
    private var avatar: UIImage?
    private let picker = UIImagePickerController()
    private var imagePicker = UIImagePickerController()
    private var selectedAvatar:String!
    private var indexAvatar = 0
    private var sounds:Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if let sounds = UserDefaults.standard.object(forKey: "sounds") as? Bool{
            self.sounds = sounds
        }else{
            self.sounds = true
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if let name = UserDefaults.standard.object(forKey: "userName") as? String {
            nameTextField.attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }else{
            nameTextField.attributedPlaceholder = NSAttributedString(string: "Player", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        }
        
      
        for button in settinsButton{
            button.layer.cornerRadius = 20
        }
        
        if let image = UserDefaults.standard.object(forKey: "avatarPhoto") as? Data {
            firstAvatar.image = UIImage(data: image)
            firstAvatar.layer.cornerRadius = 50

        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
   
    @IBAction func buyGoldButtonClicked(_ sender: UIButton) {
       
    }
    

    @IBAction func menuButtonCliked(_ sender: UIButton) {
        SoundManager.shared.buttonSound(selector: sounds)
        dismiss(animated: true)
    }
    
    
    @IBAction func soundsButtonClicked(_ sender: UIButton) {
        SoundManager.shared.buttonSound(selector: sounds)
        sounds.toggle()
        if sounds == true{
            sender.setTitle("Sounds: OFF", for: .normal)
           
        }else{
            sender.setTitle("Sounds: ON", for: .normal)
        }
        UserDefaults.standard.set(sounds, forKey: "sounds")
        
        
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        SoundManager.shared.buttonSound(selector: sounds)
        if let name = nameTextField.text {
            if name == ""{
                dismiss(animated: true)
            }
            if name.count > 4 &&  name.count < 16{
                FirebaseManager.shared.saveName(userName: name)
                dismiss(animated: true)
            }else{
                self.showAlert(delegate: self, titleText: "Error", subTitle: "Name must be more than 4 characters and less than 16", image: UIImage(named: "exit")!)
            }
            
        }
    }
    
    @IBAction func uploadPhotoButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController {
    
    func setAccName(setName: String) {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Database.database().reference().child("users")
        db.child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            if name != "" {
                UserDefaults.standard.set(name, forKey: "userName")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLabels"), object: nil)
                self.performSegue(withIdentifier: "mainVC", sender: nil)
            } else {
                db.child(userID).updateChildValues(["name":setName]) {
                    (error: Error?, ref:DatabaseReference) in
                    if let error = error {
                        self.view.hideLoading()
                    } else {
                        UserDefaults.standard.set(setName, forKey: "name")
                        self.performSegue(withIdentifier: "mainVC", sender: nil)
                    }
                }
            }
        }) { (error) in
            self.view.hideLoading()
            print(error.localizedDescription)
        }
    }
    
}

extension SettingsViewController: AlertDelegate {
    func okAction() {
        animateOut()
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            let size = min(image.size.width, image.size.height)
            let croppingRect = CGRect(x: (image.size.width - size) / 2, y: (image.size.height - size) / 2, width: size, height: size)
            let croppedImage = image.cgImage?.cropping(to: croppingRect)
            let finalImage = UIImage(cgImage: croppedImage!)
     
            avatar = finalImage
            if let pngRepresentation = avatar?.pngData() {
                UserDefaults.standard.set(pngRepresentation, forKey: "avatarPhoto")
            }
            FirebaseManager.shared.saveNewAvatar(avatarImage: (avatar ?? UIImage(named: "avatar"))!)
            firstAvatar.image = avatar
            firstAvatar.layer.cornerRadius = 30
        
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}



