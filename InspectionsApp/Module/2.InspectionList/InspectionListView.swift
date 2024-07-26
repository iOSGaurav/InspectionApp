//
//  InspectionListView.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 24/07/24.
//

import SwiftUI

struct InspectionListView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigationManager.navigationPath) {
            VStack {
                Text("Inspection List")
            }
            .navigationBarTitle("Inspection List")
            .navigationBarItems(trailing:
                                    NavigationLink(value: "Start Inspection") {
                Text("Start Inspection")
                    .foregroundColor(.blue)
            })
            .navigationDestination(for: String.self) { value in
                StartInspectionView(viewModel: StartInspectionViewModel(questionService: StartInspectionService()))
            }
        }
    }
}
