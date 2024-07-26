//
//  LoginView.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @State private var showProgressHUD: Bool = false
    @State private var showAlert: Bool = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    @EnvironmentObject var userSession: UserSession
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                if let emailError = viewModel.emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let passwordError = viewModel.passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(viewModel.isLoggingIn ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.isLoggingIn)
                
                NavigationLink(value: "Register") {
                    Text("Register")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .navigationBarTitle("Login", displayMode: .inline)
            .onChange(of: viewModel.isLoggingIn) { isLoggingIn in
                showProgressHUD = isLoggingIn
            }
            .onChange(of: viewModel.loginSuccess) { success in
                if success {
                    self.userSession.login()
                }
            }
            .onChange(of: viewModel.errorMessage) { error in
                if let _ = error {
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationDestination(for: String.self) { value in
                RegisterView(viewModel: RegisterViewModel(registerService: RegisterService()))
            }
            
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(loginService: LoginService()))
}
