//
//  StartInspectionView.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

import SwiftUI

struct StartInspectionView: View {
    
    @ObservedObject var viewModel: StartInspectionViewModel
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        ScrollView {
            VStack() {
                if let categories = viewModel.questions?.inspection.survey.categories {
                    ForEach(categories, id: \.id) { category in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(category.name)
                                .font(.headline)
                                .padding(.bottom, 5)
                            QuestionAnswerView(questions: category.questions)
                        }
                        
                    }
                    
                    Spacer().frame(height: 20)
                    Button(action: {
                        viewModel.submitQuestions()
                    }) {
                        Text("Submit")
                            .frame(width: 90, height: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .task {
                viewModel.fetchQuestions()
            }
            .navigationBarTitle("Inspection", displayMode: .inline)
        }
    }
}

#Preview {
    StartInspectionView(viewModel: StartInspectionViewModel(questionService: StartInspectionService()))
}
