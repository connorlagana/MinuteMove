//
//  HomeView.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            ReadyView()
            HStack {
                HomeCellView(text: "My Exercises", image: .init(systemName: "book.pages.fill"))
                HomeCellView(text: "Achievements", image: .init(systemName: "star.fill"))
            }
            Spacer()
                .frame(height: 100)
        }
    }
}
