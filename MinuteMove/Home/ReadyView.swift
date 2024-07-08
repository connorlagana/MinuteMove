//
//  ReadyView.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import SwiftUI

struct ReadyView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var shouldPresntStartView = false
    var body: some View {
        VStack {
            Text("Ready for a MinuteMove?")
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .font(.system(size: 28))
                .padding()
            Button {
                shouldPresntStartView.toggle()
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
        .fullScreenCover(isPresented: $shouldPresntStartView, content: {
            StartView(viewModel: WorkoutEnvironment.shared.workoutViewModel)
        })
    }
}
