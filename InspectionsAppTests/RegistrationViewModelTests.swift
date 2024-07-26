//
//  RegistrationViewModelTests.swift
//  InspectionsAppTests
//
//  Created by Gaurav Parmar on 24/07/24.
//

import XCTest
@testable import InspectionsApp

class RegisterViewModelTests: XCTestCase {
    var viewModel: RegisterViewModel!
    var mockRegisterService: MockRegisterService!

    override func setUp() {
        super.setUp()
        mockRegisterService = MockRegisterService()
        viewModel = RegisterViewModel(registerService: mockRegisterService)
    }

    func testRegisterSuccess() {
        // Arrange
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        mockRegisterService.shouldReturnSuccess = true
        
        // Act
        viewModel.register()
        
        // Assert
        XCTAssertTrue(mockRegisterService.didCallRegister)
        XCTAssertTrue(viewModel.isRegistering)
        XCTAssertTrue(viewModel.registrationSuccess)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testRegisterFailure() {
        // Arrange
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password456"
        mockRegisterService.shouldReturnSuccess = false
        
        // Act
        viewModel.register()
        
        // Assert
        XCTAssertTrue(mockRegisterService.didCallRegister)
        XCTAssertTrue(viewModel.isRegistering)
        XCTAssertFalse(viewModel.registrationSuccess)
        XCTAssertEqual(viewModel.errorMessage, "Registration failed")
    }
    
    func testValidation() {
        // Arrange
        viewModel.email = "invalid-email"
        viewModel.password = "123"
        viewModel.confirmPassword = "321"
        
        // Act
        let isValid = viewModel.validateInputs()
        
        // Assert
        XCTAssertFalse(isValid)
        XCTAssertEqual(viewModel.emailError, "Invalid email address.")
        XCTAssertEqual(viewModel.passwordError, "Password must be at least 6 characters long.")
        XCTAssertEqual(viewModel.confirmPasswordError, "Passwords do not match.")
    }

    func testConfirmPasswordValidation() {
        // Arrange
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.confirmPassword = "password123"
        
        // Act
        let isValid = viewModel.validateInputs()
        
        // Assert
        XCTAssertTrue(isValid)
        XCTAssertNil(viewModel.confirmPasswordError)
    }
}

class MockRegisterService: RegisterServiceProtocol {
    var shouldReturnSuccess = true
    var didCallRegister = false
    
    func register(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        didCallRegister = true
        if shouldReturnSuccess {
            completion(.success(true))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Registration failed"])))
        }
    }
}
