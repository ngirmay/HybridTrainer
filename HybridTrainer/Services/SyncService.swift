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
    
    public func syncHealthData(_ healthData: HealthData) async throws {
        let body: [String: Any] = [
            "date": healthData.date.ISO8601Format(),
            "stepCount": healthData.stepCount,
            "heartRateSamples": healthData.heartRateSamples.map { sample in
                [
                    "timestamp": sample.timestamp.ISO8601Format(),
                    "value": sample.value
                ]
            },
            "averageHeartRate": healthData.averageHeartRate
        ]
        
        _ = try await APIService.shared.post(
            endpoint: "health/sync",
            body: body
        )
    }
}

// MARK: - Health Data Models
public struct HealthData: Codable {
    public let date: Date
    public let stepCount: Int
    public let heartRateSamples: [HeartRateSample]
    public let averageHeartRate: Double
    
    public init(date: Date, stepCount: Int, heartRateSamples: [HeartRateSample], averageHeartRate: Double) {
        self.date = date
        self.stepCount = stepCount
        self.heartRateSamples = heartRateSamples
        self.averageHeartRate = averageHeartRate
    }
}

// MARK: - Helper Extensions
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

private extension Date {
    func ISO8601Format() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
} 