import SwiftUI
import SwiftData
import Models

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
            let modelConfiguration = ModelConfiguration(schema: schema)
            container = try ModelContainer(for: schema, configurations: modelConfiguration)
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