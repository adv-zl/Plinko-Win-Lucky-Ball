import UIKit

let userDefaults = UserDefaults.standard

enum UDKeys {
    static let isLoggedIn: String       = "isLoggedIn"
    static let isFirstLaunch: String    = "isFirstLaunch"
    static let userId: String           = "userId"
}

public var safeAreaBottomInset: CGFloat {
    let window = UIApplication.shared.windows.first
    let bottomPadding = window!.safeAreaInsets.bottom
    return bottomPadding
}

public var safeAreaTopInset: CGFloat {
    let window = UIApplication.shared.windows.first
    let topPadding = window!.safeAreaInsets.top
    return topPadding
}

