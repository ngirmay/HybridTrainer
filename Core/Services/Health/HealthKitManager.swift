public protocol HealthKitManaging {
    func requestAuthorization() async throws
    func fetchWorkouts(from: Date, to: Date) async throws -> [Workout]
    func saveWorkout(_ workout: Workout) async throws
}

public final class HealthKitManager: HealthKitManaging {
    private let healthStore: HKHealthStore
    
    public init() {
        self.healthStore = HKHealthStore()
    }
    
    // Implementation...
} 