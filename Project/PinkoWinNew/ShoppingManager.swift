
import Foundation


class ShoppingManager {
    private init(){}
    static let shared = ShoppingManager()
    private let defaults = UserDefaults.standard
    
    func purchasedSkin(team: Int){
        if var array = defaults.array(forKey: "purchasedSkin") as? [Int] {
            array.append(team)
            defaults.set(array, forKey: "purchasedSkin")
            defaults.synchronize()
            
        }else {
            let field = [team]
            defaults.set(field, forKey: "purchasedSkin")
            defaults.synchronize()
        }
    }
}
