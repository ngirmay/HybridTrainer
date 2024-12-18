import Foundation
import SwiftData

class DependencyContainer {
    static let shared = DependencyContainer()
    
    // Core services
    let healthKitService: HealthKitService
    let workoutDataService: WorkoutDataService
    let analyticsService: AnalyticsService
    
    private init() {
        // Initialize core services
        self.healthKitService = HealthKitService.shared
        
        // Create a temporary model container for initialization
        let schema = Schema([
            Goal.self,
            Workout.self,
            TrainingSession.self,
            WeeklyVolume.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)
        guard let container = try? ModelContainer(for: schema, configurations: modelConfiguration) else {
            fatalError("Failed to initialize ModelContainer")
        }
        
        // Initialize services with dependencies
        self.workoutDataService = WorkoutDataService(modelContext: container.mainContext)
        self.analyticsService = AnalyticsService()
    }
    
    // Factory methods for ViewModels
    func makeWorkoutViewModel(modelContext: ModelContext) -> WorkoutViewModel {
        WorkoutViewModel(modelContext: modelContext)
    }
} 