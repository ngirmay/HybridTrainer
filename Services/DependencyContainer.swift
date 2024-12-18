import Foundation
import SwiftData
import Models

class DependencyContainer {
    static let shared = DependencyContainer()
    
    // Core services
    let healthKitService: HealthKitService
    let workoutDataService: WorkoutDataService
    let analyticsService: AnalyticsService
    let modelContainer: ModelContainer
    
    private init() {
        // Initialize core services
        self.healthKitService = HealthKitService.shared
        self.analyticsService = AnalyticsService()
        
        // Create the model container
        let schema = Schema([
            Goal.self,
            Workout.self,
            TrainingSession.self,
            WeeklyVolume.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)
        
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: modelConfiguration)
            // Initialize services with dependencies
            self.workoutDataService = WorkoutDataService(modelContext: modelContainer.mainContext)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    // Factory methods for ViewModels
    func makeWorkoutViewModel(modelContext: ModelContext) -> WorkoutViewModel {
        WorkoutViewModel(modelContext: modelContext)
    }
} 