//
//  BarChartView.swift
//  MinuteMove
//
//  Created by Coding on 7/9/24.
//

import SwiftUI
import Charts

struct BarChartView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.groupedCompletedWorkoutsCount) { workoutCount in
                BarMark(
                    x: .value("Date", workoutCount.date, unit: .day),
                    y: .value("Count", workoutCount.count)
                )
                .foregroundStyle(Color.minuteMoveBlue)
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                if let date = value.as(Date.self), let day = Calendar.current.dateComponents([.day], from: date).day {
                    if viewModel.selectedPickerString == "Week" {
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.day().month(), centered: false)
                    } else if viewModel.selectedPickerString == "Month" {
                        if day == 0 || day == 15 || day == 30 {
                            AxisGridLine()
                            AxisValueLabel(format: .dateTime.day().month(), centered: false)
                        } else {
                            AxisGridLine()
                        }
                    } else {
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.month(), centered: false)
                    }
                    
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisGridLine()
                AxisValueLabel()
            }
        }
        .chartYScale(domain: 0...16)
        .frame(height: 300)
        .padding()
    }
}
