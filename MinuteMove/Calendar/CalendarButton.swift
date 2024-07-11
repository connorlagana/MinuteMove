//
//  CalendarButton.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI

struct CalendarButton: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    var body: some View {
        NavigationLink {
            CalendarView()
                .environmentObject(viewModel)
        } label: {
            Image(systemName: "calendar")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .padding()
                .foregroundStyle(Color.minuteMoveBlue)
        }
    }
}
