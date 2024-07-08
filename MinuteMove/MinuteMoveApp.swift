//
//  MinuteMoveApp.swift
//  MinuteMove
//
//  Created by Coding on 7/7/24.
//

import SwiftUI
import SwiftData

@main
struct MinuteMoveApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
