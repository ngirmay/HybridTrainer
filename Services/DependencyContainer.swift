import SwiftUI
import SwiftData
import Models

@MainActor
class DependencyContainer {
    let healthKitManager: HealthKitManager
    let workoutService: WorkoutDataServiceProtocol
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    static let shared = DependencyContainer()
    
    private init() {
        healthKitManager = HealthKitManager.shared
        
        // Initialize ModelContainer
        let schema = Schema([
            Workout.self,
            Goal.self,
            TrainingSession.self,
            WeeklyVolume.self
        ])
        
        do {
            // Create container with just the schema
            modelContainer = try ModelContainer(for: schema)
            modelContext = ModelContext(modelContainer)
            workoutService = WorkoutDataService(
                healthKitManager: healthKitManager,
                modelContext: modelContext
            )
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
} 