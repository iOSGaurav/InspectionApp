//
//  LoginViewModelTests.swift
//  InspectionsAppTests
//
//  Created by Gaurav Parmar on 23/07/24.
//

import XCTest
@testable import InspectionsApp

@MainActor
class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var mockLoginService: MockLoginService!
    
    override func setUp() {
        super.setUp()
        mockLoginService = MockLoginService()
        viewModel = LoginViewModel(loginService: mockLoginService)
    }
    
    func testLoginSuccess() {
        // Arrange
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        mockLoginService.shouldReturnSuccess = true
        
        // Act
        viewModel.login()
        
        // Assert
        XCTAssertTrue(mockLoginService.didCallLogin)
        XCTAssertTrue(viewModel.isLoggingIn)
        XCTAssertTrue(viewModel.loginSuccess)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoginFailure() {
        // Arrange
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        mockLoginService.shouldReturnSuccess = false
        
        // Act
        viewModel.login()
        
        // Assert
        XCTAssertTrue(mockLoginService.didCallLogin)
        XCTAssertTrue(viewModel.isLoggingIn)
        XCTAssertFalse(viewModel.loginSuccess)
        XCTAssertEqual(viewModel.errorMessage, "Login failed")
    }
    
    func testValidation() {
        // Arrange
        viewModel.email = "invalid-email"
        viewModel.password = "123"
        
        // Act
        let isValid = viewModel.validateInputs()
        
        // Assert
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.emailError, "Invalid email address.")
        XCTAssertEqual(viewModel.passwordError, "Password must be at least 6 characters long.")
    }
    
    func testPasswordValidation() {
        // Arrange
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        // Act
        let isValid = viewModel.validateInputs()
        
        // Assert
        XCTAssertTrue(isValid)
        XCTAssertNil(viewModel.passwordError)
    }
}
class MockLoginService: LoginServiceProtocol {
    var shouldReturnSuccess = true
    var didCallLogin = false
    
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        didCallLogin = true
        if shouldReturnSuccess {
            completion(.success(true))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Login failed"])))
        }
    }
}
