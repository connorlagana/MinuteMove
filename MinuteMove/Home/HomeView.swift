//
//  HomeView.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel: WorkoutViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    CalendarButton()
                        .environmentObject(viewModel)
                    Spacer()
                    ProfileButton()
                }
                .padding()
                Spacer()
                    .frame(height: 60)
                if viewModel.isReadyForNextWorkout {
                    ReadyView()
                        .environmentObject(viewModel)
                } else {
                    PleaseComeBackView()
                        .environmentObject(viewModel)
                }
                HStack {
                    HomeCellView(text: "My Exercises", image: .init(systemName: "book.pages.fill"))
                    HomeCellView(text: "Achievements", image: .init(systemName: "star.fill"))
                }
                Spacer()
                    .frame(height: 100)
            }
        }
        .onAppear {
            viewModel.checkIfReadyForNextWorkout()
        }
        .tint(.minuteMovePurple)
    }
    
    init(modelContext: ModelContext) {
        let viewModel = WorkoutViewModel(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}
