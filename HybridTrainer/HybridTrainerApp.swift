import SwiftUI
import SwiftData
import Models
import HealthKit

@main
struct HybridTrainerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: Goal.self,
                additionalTypes: [
                    Workout.self,
                    TrainingSession.self,
                    WeeklyVolume.self
                ]
            )
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
} 