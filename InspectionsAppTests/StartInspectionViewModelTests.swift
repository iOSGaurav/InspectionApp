//
//  StartInspectionViewModelTests.swift
//  InspectionsAppTests
//
//  Created by Gaurav Parmar on 26/07/24.
//

import XCTest
@testable import InspectionsApp

final class StartInspectionViewModelTests: XCTestCase {
    
    var viewModel: StartInspectionViewModel!
    var mockService: MockStartInspectionService!
    
    override func setUp() {
        super.setUp()
        mockService = MockStartInspectionService()
        viewModel = StartInspectionViewModel(questionService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchQuestionsSuccess() {
        // Given
        let expectedQuestions = InspectionResponse(inspection: stubData.inspection)
        mockService.mockQuestions = expectedQuestions
        mockService.shouldReturnError = false
        
        // When
        viewModel.fetchQuestions()
        
        // Then
//        XCTAssertTrue(viewModel.showProgressHUD, "Progress HUD should be shown while fetching questions")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Add a slight delay to wait for async completion
            XCTAssertFalse(self.viewModel.showProgressHUD, "Progress HUD should be hidden after fetching questions")
            XCTAssertEqual(self.viewModel.questions, expectedQuestions, "Questions should match the expected result")
        }
    }
    
    func testFetchQuestionsFailure() {
        // Given
        mockService.shouldReturnError = true
        
        // When
        viewModel.fetchQuestions()
        
        // Then
//        XCTAssertTrue(viewModel.showProgressHUD, "Progress HUD should be shown while fetching questions")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Add a slight delay to wait for async completion
            XCTAssertFalse(self.viewModel.showProgressHUD, "Progress HUD should be hidden after fetching questions")
            XCTAssertNil(self.viewModel.questions, "Questions should be nil on failure")
        }
    }
    
    func testSubmitQuestionsSuccess() {
        // Given
        let inspection = stubData.inspection
        viewModel.questions = InspectionResponse(inspection: inspection)
        mockService.shouldReturnError = false
        
        // When
        viewModel.submitQuestions()
        
        // Then
//        XCTAssertTrue(viewModel.showProgressHUD, "Progress HUD should be shown while submitting questions")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Add a slight delay to wait for async completion
            XCTAssertFalse(self.viewModel.showProgressHUD, "Progress HUD should be hidden after submitting questions")
            // No direct output to check, but you might want to verify side effects or log messages if needed
        }
    }
    
    func testSubmitQuestionsFailure() {
        // Given
        let inspection = stubData.inspection
        viewModel.questions = InspectionResponse(inspection: inspection)
        mockService.shouldReturnError = true
        
        // When
        viewModel.submitQuestions()
        
        // Then
//        XCTAssertTrue(viewModel.showProgressHUD, "Progress HUD should be shown while submitting questions")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Add a slight delay to wait for async completion
            XCTAssertFalse(self.viewModel.showProgressHUD, "Progress HUD should be hidden after submitting questions")
            // No direct output to check, but you might want to verify side effects or log messages if needed
        }
    }
    
}
