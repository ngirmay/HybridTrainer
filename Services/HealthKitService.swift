//
//  HealthKitService.swift
//  HybridTrainer
//

import HealthKit
import SwiftData

class HealthKitService {
    static let shared = HealthKitService()
    private let healthKitManager = HealthKitManager.shared
    
    func fetchAndProcessWorkouts() async -> [Workout] {
        return await withCheckedContinuation { continuation in
            healthKitManager.fetchAllTriathlonWorkouts { result in
                switch result {
                case .success(let workoutsByType):
                    var processedWorkouts: [Workout] = []
                    for (type, workouts) in workoutsByType {
                        for hkWorkout in workouts {
                            let workout = Workout(
                                date: hkWorkout.startDate,
                                type: self.mapWorkoutType(type),
                                duration: hkWorkout.duration
                            )
                            
                            Task {
                                if let stats = try? await self.fetchWorkoutStats(for: hkWorkout) {
                                    workout.distance = stats.totalDistance
                                    workout.calories = stats.totalEnergyBurned
                                    workout.averageHeartRate = stats.averageHeartRate
                                    workout.maxHeartRate = stats.maxHeartRate
                                    workout.strokeCount = Int(stats.strokeCount ?? 0)
                                    workout.tss = self.calculateTSS(
                                        duration: workout.duration,
                                        avgHeartRate: stats.averageHeartRate,
                                        maxHeartRate: stats.maxHeartRate
                                    )
                                }
                            }
                            processedWorkouts.append(workout)
                        }
                    }
                    continuation.resume(returning: processedWorkouts)
                case .failure:
                    continuation.resume(returning: [])
                }
            }
        }
    }
    
    private func mapWorkoutType(_ type: String) -> WorkoutType {
        switch type {
        case "swim": return .swim
        case "bike": return .bike
        case "run": return .run
        default: return .strength
        }
    }
    
    private func calculateTSS(duration: TimeInterval, avgHeartRate: Double?, maxHeartRate: Double?) -> Double? {
        guard let avgHR = avgHeartRate, let maxHR = maxHeartRate else { return nil }
        
        let hrReserve = maxHR - 60
        let hrLoad = (avgHR - 60) / hrReserve
        let intensity = pow(hrLoad, 2)
        let tss = (duration / 3600.0) * 100.0 * intensity
        
        return tss
    }
    
    func fetchWorkoutStats(for workout: HKWorkout) async throws -> WorkoutStats {
        return try await withCheckedThrowingContinuation { continuation in
            healthKitManager.fetchWorkoutStats(for: workout) { result in
                switch result {
                case .success(let stats):
                    continuation.resume(returning: stats)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

