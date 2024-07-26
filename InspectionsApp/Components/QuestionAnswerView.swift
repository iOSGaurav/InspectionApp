//
//  QuestionAnswerView.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

import SwiftUI

struct QuestionAnswerView: View {
    var questions: [Question]
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(questions) { question in
                VStack(alignment: .leading, spacing: 5) {
                    Text(question.name)
                        .font(.headline)
                    RadioGroupView(question: question)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    QuestionAnswerView(questions: question1)
}
