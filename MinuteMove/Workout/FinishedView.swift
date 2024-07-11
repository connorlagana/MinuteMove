//
//  FinishedView.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI
import Lottie

struct FinishedView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        if viewModel.finished {
            VStack {
                LottieView(animation: .named("congrats")).looping()
                    .frame(width: 300, height: 300)
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Finish")
                        .frame(width: 160, height: 80)
                        .background(Color.minuteMoveBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .semibold))
                }
            }

        } else {
            VStack {
                Text("Did you complete the workout?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(Color.minuteMovePurple)
                    .frame(width: 280, height: 120)
                    .padding()
                HStack {
                    FinishedButton(didComplete: true)
                        .environmentObject(viewModel)
                    FinishedButton(didComplete: false)
                        .environmentObject(viewModel)
                }
            }
        }
    }
}

struct FinishedButton: View {
    let didComplete: Bool
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    var body: some View {
        Button {
            if didComplete {
                viewModel.runDidFinishSequence(workout: .init(name: viewModel.lastWorkout?.name ?? "", timestamp: Date()))
            } else {
                viewModel.runDidNotFinishSequence()
            }
        } label: {
            Text(didComplete ? "Yes" : "No")
                .frame(width: 160, height: 80)
                .background(didComplete ? .green : .red)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(.white)
                .font(.system(size: 32, weight: .semibold))
        }

    }
}
