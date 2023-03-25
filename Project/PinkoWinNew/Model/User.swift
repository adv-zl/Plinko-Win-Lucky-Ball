import Foundation
import Firebase

struct User {
    let uid: String
    let userName: String
    let userAvatar: String
    let gold: Int?
 
    
    // Инициализатор для создания объекта User из Firebase DataSnapshot
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
              let userName = dict["userName"] as? String,
              let userAvatar = dict["userAvatar"] as? String,
              let gold = dict["gold"] as? Int
        else { return nil }
        
        self.uid = snapshot.key
        self.userAvatar = userAvatar
        self.userName = userName
        self.gold = gold
    }
}
