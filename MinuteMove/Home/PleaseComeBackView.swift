//
//  PleaseComeBackView.swift
//  MinuteMove
//
//  Created by Coding on 7/9/24.
//

import SwiftUI

struct PleaseComeBackView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    var body: some View {
        VStack {
            Text("Come back at \(viewModel.getTimeToComeback()) to complete another MinuteMove!")
                .font(.system(size: 28))
                .foregroundStyle(Color.gray)
                .frame(width: 280, height: 120)
                .padding()
                .animation(.easeOut, value: viewModel.workoutBottomText)
                .multilineTextAlignment(.center)
            Button {
                viewModel.checkIfReadyForNextWorkout()
            } label: {
                Text("Refresh")
                    .foregroundStyle(.white)
                    .frame(width: 220, height: 60)
                    .background(Color.minuteMovePurple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .font(.system(size: 28, weight: .bold))
            }

        }
    }
}
