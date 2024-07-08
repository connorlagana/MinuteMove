//
//  WorkoutViewModel.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var currentProgress: Double = 0
    @Published var timerCount = 60.0
    @Published var workoutBottomText = "Let's Go!"
    @Published var timerDidReachEnd = false
    var workouts = [Workout]()
    private var lastWorkout: Workout? = nil
    private var timer = Timer()
    private var totalTime = 60.0
    private var timerIsOn = false
    
    init() {
        addWorkouts()
    }
    
    public func startWorkout() {
        guard !timerIsOn else { return }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerDidGoOff), userInfo: nil, repeats: true)
        timer.fire()
        timerIsOn = true
    }
    
    public func findRandomWorkout() -> Workout? {
        let tempWorkout = workouts.randomElement()
        if lastWorkout?.name == tempWorkout?.name {
            while lastWorkout?.name == tempWorkout?.name {
                lastWorkout = workouts.randomElement()
            }
        } else {
            lastWorkout = tempWorkout
        }

        return lastWorkout
    }
    
    @objc private func timerDidGoOff() {
        if timerCount == 0 {
            timerReachedEnd()
            return
        }
        currentProgress = (totalTime - Double(timerCount)) / totalTime
        timerCount -= 1
        
        if timerCount <= 10 {
            workoutBottomText = "Almost there!"
        } else if timerCount <= 20 {
            workoutBottomText = "Keep going!"
        } else if timerCount <= 30 {
            workoutBottomText = "You can do it!"
        } else {
            workoutBottomText = "You're doing great!"
        }
    }
    
    private func timerReachedEnd() {
        timerIsOn = false
        timerDidReachEnd = true
        timer.invalidate()
    }
    
    private func addWorkouts() {
        let w1 = Workout(name: "Plank", image: Image(systemName: "star"))
        let w2 = Workout(name: "Pushup", image: Image(systemName: "star"))
        let w3 = Workout(name: "Situp", image: Image(systemName: "star"))
        let w4 = Workout(name: "Squat", image: Image(systemName: "star"))
        let w5 = Workout(name: "Pullup", image: Image(systemName: "star"))
        
        workouts.append(w1)
        workouts.append(w2)
        workouts.append(w3)
        workouts.append(w4)
        workouts.append(w5)
    }
}

struct Workout {
    let name: String
    let image: Image
}

class WorkoutEnvironment: NSObject {
    static let shared = WorkoutEnvironment()

    let workoutViewModel: WorkoutViewModel
    override init() {
        workoutViewModel = WorkoutViewModel()
    }
}
