import Foundation
import HealthKit

public class SyncService {
    public static let shared = SyncService()
    private let healthKitService = HealthKitService.shared
    private let cacheService = CacheService.shared
    
    public func syncWorkouts() async throws {
        let unsyncedWorkouts = try cacheService.getUnsyncedWorkouts()
        
        for workout in unsyncedWorkouts {
            do {
                _ = try await APIService.shared.post(
                    endpoint: "workouts/sync",
                    body: workout.dictionary
                )
                
                try await cacheService.markAsSynced(workoutId: workout.id)
            } catch {
                print("Failed to sync workout: \(error)")
            }
        }
    }
}

private extension WorkoutData {
    var dictionary: [String: Any] {
        [
            "id": id,
            "type": type,
            "startDate": startDate.ISO8601Format(),
            "endDate": endDate.ISO8601Format(),
            "duration": duration,
            "distance": distance as Any,
            "energyBurned": energyBurned as Any,
            "heartRate": heartRate as Any
        ]
    }
} 