import Foundation

class State {
    
    // MARK: - Variables
    
    // Shared variable
    public static var shared: State = State()
    
    // MARK: - Functions
    
    // Is first launch
    
    public func isNotFirstLaunch() -> Bool {
        return userDefaults.bool(forKey: UDKeys.isFirstLaunch)
    }
    
    public func setIsNotFirstLaunch() {
        userDefaults.set(true, forKey: UDKeys.isFirstLaunch)
    }
    
    // Is logged in
    
    public func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: UDKeys.isLoggedIn)
        
    }
    
    public func setIsLoggedIn(to isLogged: Bool) {
        userDefaults.set(isLogged, forKey: UDKeys.isLoggedIn)
    }
    
    // User id
    
    public func setUserId(to id: String) {
        userDefaults.setValue(id, forKey: UDKeys.userId)
    }
    
    public func getUserId() -> String {
        return userDefaults.string(forKey: UDKeys.userId) ?? ""
    }
    
    
}
