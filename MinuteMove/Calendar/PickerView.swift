//
//  PickerView.swift
//  MinuteMove
//
//  Created by Coding on 7/10/24.
//

import SwiftUI

struct PickerView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    let options = ["Week", "Month", "Year"]
    
    var body: some View {
        VStack {
            Picker("Select Time Frame", selection: $viewModel.selectedPickerString) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: viewModel.selectedPickerString) { newValue in
                viewModel.countWorkoutsPerDay()
            }
        }
    }
}
