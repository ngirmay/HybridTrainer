import SwiftUI
import SwiftData
import Models
import HealthKit

@main
struct HybridTrainerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let schema = Schema([
                Goal.self,
                Workout.self,
                TrainingSession.self,
                WeeklyVolume.self
            ])
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false,
                allowsSave: true
            )
            container = try ModelContainer(for: schema, configurations: modelConfiguration)
            
            // Request HealthKit authorization
            Task {
                do {
                    try await HealthKitService.shared.requestAuthorization()
                } catch {
                    print("HealthKit authorization failed: \(error)")
                }
            }
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