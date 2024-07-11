//
//  ReadyView.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import SwiftUI

struct ReadyView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: WorkoutViewModel
    var body: some View {
        VStack {
            Text("Ready for a MinuteMove?")
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .font(.system(size: 28))
                .padding()
            NavigationLink() {
                StartView(viewModel: viewModel)
            } label: {
                Text("Let's Go!")
                    .frame(width: 140, height: 50)
                    .background(Color.minuteMovePurple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
            }
            Spacer()
        }
    }
}
