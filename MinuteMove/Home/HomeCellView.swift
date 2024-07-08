//
//  HomeCellView.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import SwiftUI

struct HomeCellView: View {
    let text: String
    let image: Image
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .frame(height: 48)
                .padding()
            Text(text)
                .font(.system(size: 24))
        }
        .frame(width: 160, height: 240)
        .background(Color.minuteMoveBlue)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
        .padding()
    }
}
