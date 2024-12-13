//
//  HealthKitService.swift
//  HybridTrainer
//

import Foundation
import HealthKit
import SwiftData

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
                    let (avgHR, maxHR) = try await self.fetchHeartRateData(for: hkWorkout)
                    
                    return Workout(
                        date: hkWorkout.startDate,
                        type: WorkoutType.from(healthKitType: hkWorkout.workoutActivityType),
                        duration: hkWorkout.duration,
                        distance: hkWorkout.totalDistance?.doubleValue(for: .meter()) ?? 0,
                        calories: hkWorkout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0,
                        averageHeartRate: avgHR,
                        maxHeartRate: maxHR
                    )
                }
            }
            
            var processedWorkouts: [Workout] = []
            for try await workout in group {
                processedWorkouts.append(workout)
            }
            return processedWorkouts
        }
    }
    
    private func fetchHeartRateData(for workout: HKWorkout) async throws -> (average: Double?, max: Double?) {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: workout.startDate, end: workout.endDate)
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKStatisticsQuery(
                quantityType: heartRateType,
                quantitySamplePredicate: predicate,
                options: [.discreteAverage, .discreteMax]
            ) { _, statistics, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                let avgHeartRate = statistics?.averageQuantity()?.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                let maxHeartRate = statistics?.maximumQuantity()?.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                
                continuation.resume(returning: (avgHeartRate, maxHeartRate))
            }
            
            healthStore.execute(query)
        }
    }
}

