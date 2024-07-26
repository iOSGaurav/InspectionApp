//
//  StartInspectionViewModel.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//
import SwiftUI
import Combine

class StartInspectionViewModel: ObservableObject {
    
    @Published var questions: InspectionResponse?
    @Published var showProgressHUD: Bool = false
    private let questionService: StartInspectionServiceProtocol
    
    init(questionService: StartInspectionServiceProtocol) {
        self.questionService = questionService
    }
    
    func fetchQuestions() {
        self.showProgressHUD = true
        questionService.fetchQuestions { result in
            self.showProgressHUD = false
            DispatchQueue.main.async {
                switch result {
                case .success(let questions):
                    self.questions = questions
                case .failure(let error):
                    print("Failed to fetch questions: \(error)")
                    // Handle error state as needed
                }
            }
        }
    }
    
    func submitQuestions() {
        self.showProgressHUD = true
        guard let inspection = questions?.inspection else { return }
        questionService.submitQuestion(inspection) { result in
            self.showProgressHUD = false
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("success")
                case .failure(let error):
                    print("Failed to fetch questions: \(error)")
                    // Handle error state as needed
                }
            }
        }
    }
}
