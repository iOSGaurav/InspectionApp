//
//  NavigationManager.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 26/07/24.
//

import SwiftUI
import Foundation

class NavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: AnyHashable) {
        navigationPath.append(destination)
    }
    
    func goBack() {
        navigationPath.removeLast()
    }
    
    func reset() {
        navigationPath = NavigationPath()  // Reassign a new instance to clear the path
    }
}
