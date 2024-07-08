//
//  FinishedView.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI

struct FinishedView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    var body: some View {
        Text("Did you complete the workout?")
            .font(.system(size: 32, weight: .bold))
            .foregroundStyle(Color.minuteMovePurple)
            .frame(width: 280, height: 120)
            .padding()
    }
}

#Preview {
    FinishedView()
}
