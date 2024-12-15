//
//  HealthKitService.swift
//  HybridTrainer
//

import Foundation
import HealthKit
import SwiftData
import Models

class HealthKitService {
    static let shared = HealthKitService()
    private let healthStore = HKHealthStore()
    
    private init() {}
    
    func requestAuthorization() async throws {
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.quantityType(forIdentifier: .distanceSwimming)!
        ]
        
        try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
    }
    
    func fetchWorkouts() async throws -> [Workout] {
        let workoutType = HKObjectType.workoutType()
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date())
        
        let workouts = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKWorkout], Error>) in
            let query = HKSampleQuery(
                sampleType: workoutType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sortDescriptor]
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let workouts = samples as? [HKWorkout] else {
                    continuation.resume(returning: [])
                    return
                }
                
                continuation.resume(returning: workouts)
            }
            
            healthStore.execute(query)
        }
        
        return try await withThrowingTaskGroup(of: Workout.self) { group in
            for hkWorkout in workouts {
                group.addTask {
                    return Workout(
                        type: WorkoutType.from(healthKitType: hkWorkout.workoutActivityType),
                        startDate: hkWorkout.startDate,
                        duration: hkWorkout.duration,
                        distance: hkWorkout.totalDistance?.doubleValue(for: .meter()),
                        calories: hkWorkout.totalEnergyBurned?.doubleValue(for: .kilocalorie())
                    )
                }
            }
            
            var processedWorkouts: [Workout] = []
            for try await workout in group {
                processedWorkouts.append(workout)
            }
            return processedWorkouts.sorted { $0.startDate > $1.startDate }
        }
    }
}

