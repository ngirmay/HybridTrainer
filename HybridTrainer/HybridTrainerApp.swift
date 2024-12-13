//
//  HybridTrainerApp.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/10/24.
//

import SwiftUI
import SwiftData

@main
struct HybridTrainerApp: App {
    init() {
        Task {
            do {
                try await HealthKitManager.shared.requestAuthorization()
            } catch {
                print("HealthKit authorization failed: \(error)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Goal.self, Workout.self, TrainingSession.self])
    }
}

