//
//  UserSession.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

import SwiftUI

class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    
    func login() {
        isLoggedIn = true
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    func logout() {
        // Perform logout logic
        isLoggedIn = false
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
    func checkLogin() {
        // This might involve checking user defaults, keychain, or session tokens
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
