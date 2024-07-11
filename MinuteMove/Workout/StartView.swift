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
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            VStack {
                Text("Your workout for today is...")
                    .padding()
                HomeCellView(text: workout.name, image: workout.image)
                Button {
                    ///Show how to view
                } label: {
                    WorkoutBottomButtonView(text: "Tutorial", image: Image(systemName: "questionmark.circle"), color: Color.minuteMovePurple)
                }
                NavigationLink {
                    WorkoutView(viewModel: viewModel)
                } label: {
                    WorkoutBottomButtonView(text: "Continue", image: Image(systemName: "arrow.right.circle"), color: Color.minuteMoveBlue)
                    
                }
                Button {
                    workout = viewModel.findRandomWorkout()!
                } label: {
                    WorkoutBottomButtonView(text: "Roll Again", image: Image(systemName: "dice.fill"), color: Color.minuteMovePurple)
                }
                
            }
        }
        .onAppear {
            workout = viewModel.findRandomWorkout()!
        }
        .navigationBarItems(leading: Button(action : {
            self.showAlert = true
        }){
            Image(systemName: "arrow.left")
        })
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Workout will be forfeited"),
                message: Text("If you leave this page, you will have to wait an hour to log a workout again. Are you sure you'd like to go back?"),
                primaryButton: .destructive(Text("Yes")) {
                    self.presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct WorkoutBottomButtonView: View {
    let text: String
    let image: Image
    let color: Color
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 24))
                .padding()
            Spacer()
            image
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .padding()
        }
        .frame(width: 220, height: 60)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundStyle(.white)
    }
}
