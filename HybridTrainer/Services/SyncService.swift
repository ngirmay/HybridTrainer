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
                
                try await Task { @MainActor in
                    try cacheService.markAsSynced(workoutId: workout.id)
                }
            } catch {
                print("Failed to sync workout: \(error)")
            }
        }
    }
    
    public func syncHealthData(_ healthData: DailyHealthData) async throws {
        _ = try await APIService.shared.post(
            endpoint: "health/sync",
            body: [
                "date": healthData.date.ISO8601Format(),
                "stepCount": healthData.stepCount,
                "heartRateSamples": healthData.heartRateSamples.map { [
                    "timestamp": $0.timestamp.ISO8601Format(),
                    "value": $0.value
                ]},
                "averageHeartRate": healthData.averageHeartRate
            ]
        )
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