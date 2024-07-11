//
//  WorkoutView.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var body: some View {
        VStack {
            if viewModel.timerDidReachEnd {
                FinishedView()
                    .environmentObject(viewModel)
            } else {
                Text("You will have 1 minute to complete this exercise.")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(Color.gray)
                    .frame(width: 280, height: 120)
                    .padding(4)
                    .animation(.easeOut, value: viewModel.workoutBottomText)
                TimerView()
                    .environmentObject(viewModel)
                WorkoutBottomTextView()
                    .environmentObject(viewModel)
            }
        }
        .animation(.default, value: viewModel.timerDidReachEnd)
        .navigationBarBackButtonHidden(true)
    }
}

struct WorkoutBottomTextView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    var body: some View {
        Text(viewModel.workoutBottomText)
            .font(.system(size: 32, weight: .bold))
            .foregroundStyle(Color.minuteMovePurple)
            .frame(width: 280, height: 120)
            .padding()
            .animation(.easeOut, value: viewModel.workoutBottomText)
    }
}
