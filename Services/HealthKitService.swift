//
//  HealthKitService.swift
//  HybridTrainer
//

import Foundation
import HealthKit

class HealthKitService {
    static let shared = HealthKitService()
    private let healthStore = HKHealthStore()
    
    private init() {}
    
    func requestAuthorization() async throws {
        let typesToRead: Set<HKObjectType> = [
            .workoutType(),
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.quantityType(forIdentifier: .distanceSwimming)!
        ]
        
        try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
    }
    
    func fetchWorkouts(limit: Int = 0) async throws -> [HKWorkout] {
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .greaterThan)
        let sortDescriptor = SortDescriptor(\HKWorkout.startDate, order: .reverse)
        
        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: workoutPredicate,
            limit: limit == 0 ? HKObjectQueryNoLimit : limit,
            sortDescriptors: [sortDescriptor],
            resultsHandler: { query, samples, error in
                if let error = error {
                    print("Error fetching workouts: \(error)")
                    return
                }
                
                guard let workouts = samples as? [HKWorkout] else {
                    print("Error: Could not convert samples to workouts")
                    return
                }
                
                // Process workouts here
            }
        )
        
        healthStore.execute(query)
        return try await fetchWorkoutsAsync(limit: limit)
    }
    
    private func fetchWorkoutsAsync(limit: Int) async throws -> [HKWorkout] {
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .greaterThan)
        let sortDescriptor = SortDescriptor(\HKWorkout.startDate, order: .reverse)
        
        let samples = try await healthStore.samples(
            matching: HKSampleQuery.Parameters(
                sampleType: .workoutType(),
                predicate: workoutPredicate,
                limit: limit == 0 ? HKObjectQueryNoLimit : limit,
                sortDescriptors: [sortDescriptor]
            )
        )
        
        return samples.compactMap { $0 as? HKWorkout }
    }
    
    func fetchHeartRateData(for workout: HKWorkout) async throws -> [Double] {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(withStart: workout.startDate, end: workout.endDate)
        let sortDescriptor = SortDescriptor(\HKQuantitySample.startDate, order: .ascending)
        
        let samples = try await healthStore.samples(
            matching: HKSampleQuery.Parameters(
                sampleType: heartRateType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sortDescriptor]
            )
        )
        
        return samples.compactMap { sample in
            guard let heartRateSample = sample as? HKQuantitySample else { return nil }
            return heartRateSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        }
    }
}

