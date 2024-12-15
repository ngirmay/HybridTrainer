import SwiftUI
import SwiftData
import Models
import HealthKit

@main
struct HybridTrainerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .tint(Theme.Colors.accent)
        }
        .modelContainer(for: [
            Workout.self,
            Goal.self,
            TrainingSession.self
        ])
    }
} 