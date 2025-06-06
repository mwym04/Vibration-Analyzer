//
//  Vibration_AnalyzerApp.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/13/23.
//

import SwiftUI
import SwiftData

@main
struct Vibration_AnalyzerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            VibData.self
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
