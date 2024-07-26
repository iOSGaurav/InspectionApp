//
//  RegistrationView.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 23/07/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    @State private var showProgressHUD: Bool = false
    @State private var showAlert: Bool = false
    @EnvironmentObject var navigationManager: NavigationManager
    
    init(viewModel: RegisterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
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
            
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let confirmPasswordError = viewModel.confirmPasswordError {
                Text(confirmPasswordError)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                viewModel.register()
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(viewModel.isRegistering ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isRegistering)
        }
        .padding()
        .navigationBarTitle("Register", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                // Custom back button
                Button(action: {
                    navigationManager.goBack()
                    
                }) {
                    Image(systemName: "chevron.left") // Back arrow icon
                        .font(.title)
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide default back button
        .onChange(of: viewModel.isRegistering) { isRegistering in
            showProgressHUD = isRegistering
        }
        .onChange(of: viewModel.registrationSuccess) { success in
            if success {
                navigationManager.goBack()
            }
        }
        .onChange(of: viewModel.errorMessage) { error in
            if let _ = error {
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Registration Failed"),
                message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
#Preview {
    RegisterView(viewModel: RegisterViewModel(registerService: RegisterService()))
}
