//
//  ProfileButton.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
        Button {
            ///
        } label: {
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .padding()
                .foregroundStyle(Color.minuteMoveBlue)
        }
    }
}
