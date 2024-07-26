//
//  ProgressHUD.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 24/07/24.
//

import SwiftUI

struct ProgressHUD: View {
    @Binding var isLoading: Bool
    var text: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                
                Text(text)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .font(.body)
            }
            .padding(20)
            .background(Color.secondary.colorInvert())
            .cornerRadius(10)
            .shadow(radius: 10)
            .opacity(isLoading ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.2))
        }
    }
}
#Preview {
    ProgressHUD(isLoading: .constant(true), text: "Loading..")
}
