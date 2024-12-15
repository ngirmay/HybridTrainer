@MainActor
class DependencyContainer {
    let healthKitManager: HealthKitManager
    let workoutService: WorkoutDataServiceProtocol
    let modelContext: ModelContext
    
    static let shared = DependencyContainer()
    
    private init() {
        healthKitManager = HealthKitManager.shared
        
        // Initialize ModelContext with proper configuration
        let schema = Schema([
            Workout.self,
            Goal.self,
            TrainingSession.self,
            WeeklyVolume.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        modelContext = ModelContext(modelConfiguration)
        
        workoutService = WorkoutDataService(
            healthKitManager: healthKitManager,
            modelContext: modelContext
        )
    }
} 