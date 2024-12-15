protocol WorkoutDataServiceProtocol {
    func fetchWorkouts(from: Date?) async throws -> [DetailedWorkout]
    func saveWorkout(_ workout: DetailedWorkout) async throws
}

class WorkoutDataService: WorkoutDataServiceProtocol {
    private let healthKitManager: HealthKitManager
    private let modelContext: ModelContext
    
    init(healthKitManager: HealthKitManager, modelContext: ModelContext) {
        self.healthKitManager = healthKitManager
        self.modelContext = modelContext
    }
    
    func fetchWorkouts(from date: Date? = nil) async throws -> [DetailedWorkout] {
        // First request authorization
        try await healthKitManager.requestAuthorization()
        
        // Fetch workouts from HealthKit
        let workouts = try await healthKitManager.fetchWorkouts(from: date)
        
        // Save to SwiftData
        for workout in workouts {
            modelContext.insert(workout.workout)
        }
        try modelContext.save()
        
        return workouts
    }
    
    func saveWorkout(_ workout: DetailedWorkout) async throws {
        modelContext.insert(workout.workout)
        try modelContext.save()
    }
} 