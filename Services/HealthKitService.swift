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
                            self.healthKitManager.fetchWorkoutStats(for: hkWorkout) { statsResult in
                                if case .success(let stats) = statsResult {
                                    workout.distance = stats.totalDistance
                                    workout.calories = stats.totalEnergyBurned
                                    workout.averageHeartRate = stats.averageHeartRate
                                    workout.maxHeartRate = stats.maxHeartRate
                                    workout.strokeCount = Int(stats.strokeCount ?? 0)
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
}

