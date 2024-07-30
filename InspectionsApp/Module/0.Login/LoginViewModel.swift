//
//  LoginViewModel.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import Foundation
import Alamofire

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var isLoggingIn: Bool = false
    @Published var loginSuccess: Bool = false
    @Published var errorMessage: String?
    
    private let loginService: LoginServiceProtocol
    
    init(loginService: LoginServiceProtocol) {
        self.loginService = loginService
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func login() {
        guard validateInputs() else { return }
        
        isLoggingIn = true
        let user = User(email: email, password: password)
        
        loginService.login(user: user) { [weak self] result in
            self?.isLoggingIn = false
            switch result {
            case .success():
                // Login successful
                self?.loginSuccess = true
                self?.errorMessage = nil
            case .failure(let error):
                // Login failed
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func validateInputs() -> Bool {
        var isValid = true
        emailError = nil
        passwordError = nil
        
        if email.isEmpty || !email.contains("@") {
            emailError = "Invalid email address."
            isValid = false
        }
        
        if password.isEmpty || password.count < 6 {
            passwordError = "Password must be at least 6 characters long."
            isValid = false
        }
        
        return isValid
    }
}
