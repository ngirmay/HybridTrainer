import SwiftUI
import SwiftData

@main
struct HybridTrainerApp: App {
    @StateObject private var container: DependencyContainer
    
    init() {
        let modelContainer = try! ModelContainer(for: TrainingSession.self, PlannedWorkout.self)
        let modelContext = modelContainer.mainContext
        self._container = StateObject(wrappedValue: DependencyContainer(modelContext: modelContext))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.modelContext, container.modelContext)
                .environmentObject(container)
        }
    }
} 