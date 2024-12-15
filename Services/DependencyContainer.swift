class DependencyContainer {
    let healthKitManager: HealthKitManager
    let workoutService: WorkoutDataServiceProtocol
    let modelContext: ModelContext
    
    static let shared = DependencyContainer()
    
    private init() {
        healthKitManager = HealthKitManager.shared
        modelContext = ModelContext(/* configuration */)
        workoutService = WorkoutDataService(
            healthKitManager: healthKitManager,
            modelContext: modelContext
        )
    }
} 