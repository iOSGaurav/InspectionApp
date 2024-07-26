//
//  RegistrationViewModel.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    @Published var isRegistering: Bool = false
    @Published var registrationSuccess: Bool = false
    @Published var errorMessage: String?
    
    private let registerService: RegisterServiceProtocol
    
    init(registerService: RegisterServiceProtocol) {
        self.registerService = registerService
    }
    
    func register() {
        // Validate inputs
        guard validateInputs() else { return }
        
        isRegistering = true
        let user = User(email: email, password: password)
        
        registerService.register(user: user) { [weak self] result in
            DispatchQueue.main.async {
                self?.isRegistering = false
                switch result {
                case .success(_):
                    // Registration successful
                    self?.registrationSuccess = true
                    self?.errorMessage = nil
                case .failure(let error):
                    // Registration failed
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func validateInputs() -> Bool {
        var isValid = true
        emailError = nil
        passwordError = nil
        confirmPasswordError = nil
        
        if email.isEmpty || !email.contains("@") {
            emailError = "Invalid email address."
            isValid = false
        }
        
        if password.isEmpty || password.count < 6 {
            passwordError = "Password must be at least 6 characters long."
            isValid = false
        }
        
        if confirmPassword != password {
            confirmPasswordError = "Passwords do not match."
            isValid = false
        }
        
        return isValid
    }
}
