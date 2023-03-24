import UIKit
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init(){}
    private var ref: DatabaseReference!
    
    func saveUser(userName: String, avatarImage: UIImage) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        
        let databaseRef = Database.database().reference().child("users").child(userID)
        
        // Сохраняем имя пользователя в базу данных
        databaseRef.child("userName").setValue(userName)
        
        // Загружаем картинку в хранилище Firebase и сохраняем ссылку на неё в базу данных
        uploadAvatarImage(avatarImage) { result in
            switch result {
            case .success(let url):
                databaseRef.child("userAvatar").setValue(url.absoluteString)
            case .failure(let error):
                print("Error uploading avatar: \(error.localizedDescription)")
            }
        }
    }
    func saveName(userName: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        
        let databaseRef = Database.database().reference().child("users").child(userID)
        
        // Сохраняем имя пользователя в базу данных
        databaseRef.child("userName").setValue(userName)
        UserDefaults.standard.set(userName, forKey: "userName")
        
    }
    
    func saveNewAvatar(avatarImage: UIImage) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        let databaseRef = Database.database().reference().child("users").child(userID)
        // Загружаем картинку в хранилище Firebase и сохраняем ссылку на неё в базу данных
        uploadAvatarImage(avatarImage) { result in
            switch result {
            case .success(let url):
                databaseRef.child("userAvatar").setValue(url.absoluteString)
            case .failure(let error):
                print("Error uploading avatar: \(error.localizedDescription)")
            }
        }
        
    }
    
    func saveGold(gold: Int) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        let databaseRef = Database.database().reference().child("users").child(userID)
        
        // Сохраняем gold пользователя в базу данных
        databaseRef.child("gold").setValue(gold){ (error, _) in
            if let error = error {
                print("Failed to save gold amount: \(error.localizedDescription)")
            } else {
                print("Successfully saved gold amount")
            }
        }
        
    }
    
    func uploadAvatarImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated"])))
            return
        }
        
        let storageRef = Storage.storage().reference().child("avatars").child("\(userID).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    storageRef.downloadURL { (url, error) in
                        if let error = error {
                            completion(.failure(error))
                        } else if let url = url {
                            completion(.success(url))
                        }
                    }
                }
            }
        }
    }
    
   
    func fetchGoldAmount(completion: @escaping (Result<Int, Error>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not authenticated")
            return
        }
        
        let databaseRef = Database.database().reference().child("users").child(userID)
        databaseRef.child("gold").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let goldAmount = snapshot.value as? Int else {
                completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve gold amount"])))
                return
            }
            completion(.success(goldAmount))
        }) { (error) in
            completion(.failure(error))
        }
    }

    
}
