import SwiftUI
import SwiftData

@main
struct HybridTrainerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: Workout.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false)
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