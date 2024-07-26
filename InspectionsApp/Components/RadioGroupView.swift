//
//  RadioGroupView.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

import SwiftUI

struct RadioGroupView: View {
    @State var question: Question
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(question.answerChoices, id: \.id) { choice in
                RadioButton(text: choice.name, isSelected: question.selectedAnswerChoiceID == choice.id) {
                    self.selectAnswer(choice.id)
                }
            }
        }
    }
    
    private func selectAnswer(_ choiceIndex: Int) {
        question.selectedAnswerChoiceID = choiceIndex
    }
}
#Preview {
    RadioGroupView(question: question1[0])
}
