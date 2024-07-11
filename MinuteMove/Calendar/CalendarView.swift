//
//  CalendarView.swift
//  MinuteMove
//
//  Created by Coding on 7/8/24.
//

import Charts
import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    let options = ["Week", "Month", "Year"]

    var body: some View {
        VStack {
            PickerView()
                .environmentObject(viewModel)
            AverageView(count: $viewModel.averageCount)
                .environmentObject(viewModel)
            BarChartView()
                .environmentObject(viewModel)
            Spacer()
        }
        .onAppear {
            viewModel.fetchCompletedWorkouts()
            viewModel.countWorkoutsPerDay()
            viewModel.calculateAverageWorkoutCount()
        }
    }
}

struct AverageView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Binding var count: Int
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("AVERAGE")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.gray)
                    Spacer()
                }
                HStack {
                    Text(String(count))
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(Color.minuteMovePurple)
                    Text("workouts per day")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                    Spacer()
                }
                HStack {
                    Text("\(getDay(date: viewModel.currentRange.start, withYear: false)) - \(getDay(date: viewModel.currentRange.end, withYear: true))")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
            Spacer()
        }
        .padding()
    }
    
    func getDay(date: Date, withYear: Bool) -> String {
        let dateFormatter = DateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        var final = "\(months![month - 1]) \(day)"
        if withYear {
            final += " \(year)"
        }
        return final
    }
}
