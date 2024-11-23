//
//  Defaults.swift
//  Agent
//
//  Created by Ibrahim on 06/07/2024.
//

import Foundation
import Defaulty

struct Defaults {
    @UserDefault<Keys, Bool>(key: .userLoggedIn, defaultValue: false)
    static var userLoggedIn: Bool

    @UserDefault<Keys, Data>(key: .userData, defaultValue: .init())
    static var userData: Data

    @UserDefault<Keys, String?>(key: .token, defaultValue: nil)
    static var token: String?
    
    @UserDefault<Keys, String?>(key: .firebaseToken, defaultValue: nil)
    static var firebaseToken: String?
    
    @UserDefault<Keys, String?>(key: .userImage, defaultValue: nil)
    static var userImage: String?
    
    static func remove() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Keys.userLoggedIn.rawValue)
        defaults.removeObject(forKey: Keys.userData.rawValue)
        defaults.removeObject(forKey: Keys.token.rawValue)
        defaults.removeObject(forKey: Keys.firebaseToken.rawValue)
        defaults.removeObject(forKey: Keys.userImage.rawValue)
    }

    enum Keys: String, Key {
        case userLoggedIn
        case userData
        case token
        case firebaseToken
        case userImage
    }

    private init() { }
}
