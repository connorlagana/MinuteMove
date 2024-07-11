//
//  WorkoutViewModel.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import Foundation
import SwiftUI
import SwiftData

class WorkoutViewModel: ObservableObject {
    @Published var currentProgress: Double = 0
    @Published var timerCount = 60.0
    @Published var workoutBottomText = "Let's Go!"
    @Published var timerDidReachEnd = false
    @Published var finished: Bool = false
    @Published var isReadyForNextWorkout: Bool = true
    @Published var currentRange: DateInterval = DateInterval()
    @Published var averageCount: Int = 0
    @Published var selectedPickerString = "Week"
    
    var workouts = [Workout]()
    var lastWorkout: Workout? = nil
    var completedWorkouts = [CompletedWorkout]()
    var groupedCompletedWorkoutsCount: [CompletedWorkoutCount] = []
    
    private var modelContext: ModelContext
    private var timer = Timer()
    private var totalTime = 60.0
    private var timerIsOn = false
    private var groupedCompletedWorkouts: [Date: [CompletedWorkout]] = [:]
    private let lastWorkoutTimestampKey = "lastWorkoutTimestampKey"
    private var lastWorkoutTimestamp: Date? {
        get {
            UserDefaults.standard.object(forKey: lastWorkoutTimestampKey) as? Date
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: lastWorkoutTimestampKey)
        }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        addWorkouts()
        fetchCompletedWorkouts()
    }
    
    public func getWorkoutsFor() -> [CompletedWorkout] {

        return completedWorkouts.filter { item in
            !item.isDeleted
        }
    }
    
    public func checkIfReadyForNextWorkout() {
        if Date() > lastWorkoutTimestamp?.addingTimeInterval(60 * 60) ?? Date(timeIntervalSince1970: 0) {
            isReadyForNextWorkout = true
        } else {
            isReadyForNextWorkout = false
        }
    }
    
    public func getTimeToComeback() -> String {
        let date = lastWorkoutTimestamp?.addingTimeInterval(60 * 60) ?? Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let meridiemIndicator = hour > 12 ? "PM" : "AM"
        hour = hour > 12 ? hour - 12 : hour
        return "\(hour):\(minute) \(meridiemIndicator)"
    }
    
    func fetchCompletedWorkouts() {
        do {
            let descriptor = FetchDescriptor<CompletedWorkout>(sortBy: [SortDescriptor(\.timestamp)])
            let workouts = try modelContext.fetch(descriptor)
            completedWorkouts = workouts.filter { item in
                !item.isDeleted
            }
        } catch {
            print("Fetch failed")
        }
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
        
        lastWorkoutTimestamp = Date()
        isReadyForNextWorkout = false

        return lastWorkout
    }
    
    public func runDidNotFinishSequence() {
        
    }
    
    public func runDidFinishSequence(workout: CompletedWorkout) {
        finished = true
        modelContext.insert(workout)
    }
    
    public func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    public func addItem() {
        withAnimation {
            let newItem = CompletedWorkout(name: "Test", timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    public func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(completedWorkouts[index])
            }
        }
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
    
    private func countWorkoutsPerMonth() {
        let calendar = Calendar.current
        var monthDict = [Date: [CompletedWorkout]]()
        let today = Date()
        var firstDay: Date = Date()
        var lastDay: Date = Date(timeIntervalSince1970: 0)
        
        for i in 0..<12 {
            if let date = calendar.date(byAdding: .month, value: -i, to: today),
               let firstDateOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) {
                monthDict[firstDateOfMonth] = []
                firstDay = min(firstDay, firstDateOfMonth)
                lastDay = max(lastDay, firstDateOfMonth)
            }
        }
        
        var groupedItems = Dictionary(grouping: completedWorkouts) { (item) -> Date in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: item.timestamp)
            return calendar.date(from: components) ?? Date()
        }
        
        for (key, val) in groupedItems {
            monthDict[key, default: []] += val
        }
        
        self.currentRange = DateInterval(start: firstDay, end: lastDay)
        
        self.groupedCompletedWorkouts = monthDict
        
        self.groupedCompletedWorkoutsCount = monthDict.map { (key, value) in
            CompletedWorkoutCount(date: key, count: value.count)
        }
    }
    
    public func countWorkoutsPerDay() {
        if selectedPickerString == "Year" {
            countWorkoutsPerMonth()
            return
        }
        var groupedItems = Dictionary(grouping: completedWorkouts) { (item) -> Date in
            let calendar = Calendar.current
            return calendar.startOfDay(for: item.timestamp)
        }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let num: Int
        switch selectedPickerString {
        case "Week":
            num = 7
        case "Month":
            num = 30
        default:
            num = 12
        }
        let timeFrame = (0..<num).map { calendar.date(byAdding: .day, value: -$0, to: today)! }
        self.currentRange = DateInterval(start: timeFrame.last ?? Date(), end: timeFrame.first ?? Date())
        for day in timeFrame {
            if groupedItems[day] == nil {
                groupedItems[day] = []
            }
        }
        self.groupedCompletedWorkouts = groupedItems
        
        self.groupedCompletedWorkoutsCount = groupedItems.map { (key, value) in
            CompletedWorkoutCount(date: key, count: value.count)
        }
    }
    
    func calculateAverageWorkoutCount() {
        let totalEntries = groupedCompletedWorkouts.count
        guard totalEntries > 0 else { return }

        let totalWorkoutCount = groupedCompletedWorkouts.reduce(0) { (sum, entry) -> Int in
            return sum + entry.value.count
        }

        let averageWorkoutCount = Double(totalWorkoutCount) / Double(totalEntries)
        averageCount = Int(round(averageWorkoutCount))
    }
}

struct Workout {
    let name: String
    let image: Image
}

@Model
class CompletedWorkout {
    let name: String
    let timestamp: Date
    
    init(name: String, timestamp: Date) {
        self.name = name
        self.timestamp = timestamp
    }
}

struct CompletedWorkoutCount: Identifiable {
    var id = UUID()
    var date: Date
    var count: Int
}
