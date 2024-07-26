//
//  InspectionsAppApp.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import SwiftUI

@main
struct InspectionsAppApp: App {
    @StateObject private var userSession = UserSession()
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if userSession.isLoggedIn {
                    InspectionListView()
                        .environmentObject(userSession)
                        .environmentObject(navigationManager)
                } else {
                    LoginView(viewModel: LoginViewModel(loginService: LoginService()))
                        .environmentObject(userSession)
                        .environmentObject(navigationManager)
                }
            }
        }
    }
}
