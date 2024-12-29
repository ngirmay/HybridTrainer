import SwiftUI
import SwiftData

@main
struct HybridTrainerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let schema = Schema([
                TrainingSession.self,
                PlannedWorkout.self,
                TrainingBlock.self,
                TrainingWeek.self,
                TrainingDay.self,
                WeeklyMetrics.self
            ])
            
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            
            container = try ModelContainer(
                for: schema,
                configurations: modelConfiguration
            )
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
} 