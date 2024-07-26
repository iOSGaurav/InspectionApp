//
//  RadioButton.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//
import SwiftUI

struct RadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                action()
            }) {
                HStack {
                    Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    Text(text)
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, 5)
        }
    }
}
#Preview {
    RadioButton(text: "32", isSelected: false, action: {})
}
