//
//  LoginServiceTests.swift
//  InspectionsAppTests
//
//  Created by Gaurav Parmar on 26/07/24.
//

import XCTest
import Alamofire
@testable import InspectionsApp

class LoginServiceTests: XCTestCase {
    
    var loginService: LoginService!
    var mockAlamofire: MockAlamofireWrapper!
    
    override func setUp() {
        super.setUp()
        mockAlamofire = MockAlamofireWrapper()
        loginService = LoginService() // Pass the mockAlamofire if you refactor LoginService to accept it
    }
    
    override func tearDown() {
        loginService = nil
        mockAlamofire = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        // Given
        let user = User(email: "test@example.com", password: "password123")
        let expectedResponse: [String: Any] = ["status": "success"]
        mockAlamofire.mockResponse = .success(expectedResponse)
        
        // When
        let expectation = self.expectation(description: "Login success")
        loginService.login(user: user) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success, "Login should be successful")
            case .failure(let error):
                XCTFail("Login failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoginFailure() {
        // Given
        let user = User(email: "test@example.com", password: "password123")
        mockAlamofire.mockResponse = .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401)))
        
        // When
        let expectation = self.expectation(description: "Login failure")
        loginService.login(user: user) { result in
            switch result {
            case .success(let success):
                XCTFail("Login should have failed")
            case .failure(let error):
                XCTAssertEqual(error.asAFError?.responseCode, 401, "Login should fail with status code 401")
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
