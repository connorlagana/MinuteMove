//
//  TimerView.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    var body: some View {
        ZStack {
            CircularProgressView(progress: $viewModel.currentProgress, lineWidth: 30, color: .minuteMoveBlue)
                .frame(width: 300)
            Button {
                viewModel.startWorkout()
            } label: {
                Text(viewModel.timerCount == 60.0 ? "Start!" : String(Int(viewModel.timerCount)))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 120, height: 120)
                    .background(Color.minuteMovePurple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

        }
    }
}

struct CircularProgressView: View {
    @Binding var progress: Double
    let lineWidth: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: lineWidth
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)

        }
    }
}
