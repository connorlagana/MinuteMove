//
//  StartView.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import SwiftUI

struct StartView: View {
    let viewModel: WorkoutViewModel
    @State var workout: Workout = .init(name: "", image: Image(""))
    var body: some View {
        NavigationView {
            VStack {
                Text("Your workout for today is...")
                    .padding()
                HomeCellView(text: workout.name, image: workout.image)
                Button {
                    ///Show how to view
                } label: {
                    HStack {
                        Text("Tutorial")
                            .font(.system(size: 24))
                            .padding()
                        Spacer()
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding()
                    }
                    .frame(width: 220, height: 60)
                    .background(Color.minuteMovePurple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                }
                NavigationLink {
                    WorkoutView(viewModel: viewModel)
                } label: {
                    HStack {
                        Text("Continue")
                            .font(.system(size: 24))
                            .padding()
                        Spacer()
                        Image(systemName: "arrow.right.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding()
                    }
                    .frame(width: 220, height: 60)
                    .background(Color.minuteMoveBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                    
                }

                Button {
                    workout = viewModel.findRandomWorkout()!
                } label: {
                    HStack {
                        Text("Roll Again")
                            .font(.system(size: 24))
                            .padding()
                        Spacer()
                        Image(systemName: "dice.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding()
                    }
                    .frame(width: 220, height: 60)
                    .background(Color.minuteMovePurple)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                }
            }
        }
        .onAppear {
            workout = viewModel.findRandomWorkout()!
        }
    }
}
