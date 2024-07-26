//
//  MockStartInspectionService.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 26/07/24.
//

import Foundation
import XCTest
@testable import InspectionsApp

// Mock for StartInspectionService
class MockStartInspectionService: StartInspectionServiceProtocol {
    
    var shouldReturnError = false
    var mockQuestions: InspectionResponse?
    
    func fetchQuestions(completion: @escaping (Result<InspectionResponse, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Fetch error"])))
        } else {
            completion(.success(mockQuestions!))
        }
    }
    
    func submitQuestion(_ inspection: Inspection, completion: @escaping (Result<Bool, any Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Submit error"])))
        } else {
            completion(.success((true)))
        }
    }
}
