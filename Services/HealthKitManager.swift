//
//  HealthKitManager.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/10/24.
//

import HealthKit
import Foundation

class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()
    
    private init() {}
    
    // MARK: - Request Authorization
    func requestAuthorization() async throws {
        guard HKHealthStore.isHealthDataAvailable() else {
            throw HealthError.notAvailable
        }
        
        let types = Set([
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount)!,
            HKObjectType.quantityType(forIdentifier: .vo2Max)!
        ])
        
        try await healthStore.requestAuthorization(toShare: types, read: types)
    }
    
    // MARK: - Fetch Recent Workouts
    func fetchRecentWorkouts(completion: @escaping (Result<[HKWorkout], Error>) -> Void) {
        let zeroDistance = HKQuantity(unit: .meter(), doubleValue: 0)
        
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .greaterThanOrEqualTo,
                                                           totalDistance: zeroDistance)
        
        let query = HKSampleQuery(
            sampleType: HKObjectType.workoutType(),
            predicate: workoutPredicate,
            limit: 10,
            sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
        ) { _, samples, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let workouts = samples as? [HKWorkout] ?? []
            completion(.success(workouts))
        }
        
        healthStore.execute(query)
    }
    
    // MARK: - Fetch All Triathlon Workouts
    func fetchAllTriathlonWorkouts(completion: @escaping (Result<[String: [HKWorkout]], Error>) -> Void) {
        let group = DispatchGroup()
        var workouts: [String: [HKWorkout]] = [
            "swim": [],
            "bike": [],
            "run": []
        ]
        var fetchError: Error?
        
        // Fetch Swimming Workouts
        group.enter()
        fetchWorkoutsByType(.swimming) { result in
            switch result {
            case .success(let swimWorkouts):
                workouts["swim"] = swimWorkouts
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }
        
        // Fetch Cycling Workouts
        group.enter()
        fetchWorkoutsByType(.cycling) { result in
            switch result {
            case .success(let bikeWorkouts):
                workouts["bike"] = bikeWorkouts
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }
        
        // Fetch Running Workouts
        group.enter()
        fetchWorkoutsByType(.running) { result in
            switch result {
            case .success(let runWorkouts):
                workouts["run"] = runWorkouts
            case .failure(let error):
                fetchError = error
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
            } else {
                completion(.success(workouts))
            }
        }
    }
    
    // MARK: - Fetch Workouts By Type
    private func fetchWorkoutsByType(_ type: HKWorkoutActivityType,
                                   completion: @escaping (Result<[HKWorkout], Error>) -> Void) {
        let predicate = HKQuery.predicateForWorkouts(with: type)
        
        let query = HKSampleQuery(
            sampleType: .workoutType(),
            predicate: predicate,
            limit: HKObjectQueryNoLimit,
            sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)]
        ) { _, samples, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let workouts = samples as? [HKWorkout] ?? []
            completion(.success(workouts))
        }
        
        healthStore.execute(query)
    }
    
    // MARK: - Fetch Workout Statistics
    func fetchWorkoutStats(for workout: HKWorkout,
                          completion: @escaping (Result<WorkoutStats, Error>) -> Void) {
        let group = DispatchGroup()
        var stats = WorkoutStats()
        var fetchError: Error?
        
        // Fetch heart rate if available
        if let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) {
            group.enter()
            let predicate = HKQuery.predicateForSamples(
                withStart: workout.startDate,
                end: workout.endDate,
                options: .strictStartDate
            )
            
            let query = HKStatisticsQuery(
                quantityType: heartRateType,
                quantitySamplePredicate: predicate,
                options: [.discreteAverage, .discreteMin, .discreteMax]
            ) { _, statistics, error in
                defer { group.leave() }
                
                if let error = error {
                    fetchError = error
                    return
                }
                
                let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
                stats.averageHeartRate = statistics?.averageQuantity()?.doubleValue(for: heartRateUnit)
                stats.minHeartRate = statistics?.minimumQuantity()?.doubleValue(for: heartRateUnit)
                stats.maxHeartRate = statistics?.maximumQuantity()?.doubleValue(for: heartRateUnit)
            }
            
            healthStore.execute(query)
        }
        
        // Fetch energy burned
        if let energyBurnedType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) {
            group.enter()
            let predicate = HKQuery.predicateForSamples(
                withStart: workout.startDate,
                end: workout.endDate,
                options: .strictStartDate
            )
            
            let query = HKStatisticsQuery(
                quantityType: energyBurnedType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, statistics, error in
                defer { group.leave() }
                
                if let error = error {
                    fetchError = error
                    return
                }
                
                stats.totalEnergyBurned = statistics?.sumQuantity()?.doubleValue(for: .kilocalorie())
            }
            
            healthStore.execute(query)
        }
        
        // Add swimming-specific metrics if it's a swim workout
        if workout.workoutActivityType == .swimming {
            if let strokeType = HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount) {
                group.enter()
                let predicate = HKQuery.predicateForSamples(
                    withStart: workout.startDate,
                    end: workout.endDate,
                    options: .strictStartDate
                )
                
                let query = HKStatisticsQuery(
                    quantityType: strokeType,
                    quantitySamplePredicate: predicate,
                    options: .cumulativeSum
                ) { _, statistics, error in
                    defer { group.leave() }
                    
                    if let error = error {
                        fetchError = error
                        return
                    }
                    
                    stats.strokeCount = statistics?.sumQuantity()?.doubleValue(for: .count())
                }
                
                healthStore.execute(query)
            }
        }
        
        group.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
            } else {
                stats.duration = workout.duration
                stats.totalDistance = workout.totalDistance?.doubleValue(for: .meter())
                completion(.success(stats))
            }
        }
    }
    
    // MARK: - Supporting Types
    struct WorkoutStats {
        var duration: TimeInterval = 0
        var totalDistance: Double?
        var totalEnergyBurned: Double?
        var averageHeartRate: Double?
        var minHeartRate: Double?
        var maxHeartRate: Double?
        var strokeCount: Double?
        
        // Computed properties for easy access
        var durationInMinutes: Double {
            return duration / 60.0
        }
        
        var distanceInKilometers: Double? {
            guard let distance = totalDistance else { return nil }
            return distance / 1000.0
        }
    }
    
    // MARK: - Errors
    enum HealthError: Error {
        case notAvailable
        case authorizationDenied
        case dataTypeUnavailable
    }
}
