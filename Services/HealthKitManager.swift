//
//  HealthKitManager.swift
//  HybridTrainer
//

import HealthKit
import Foundation

class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()
    
    private init() {}
    
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
    
    func fetchAllTriathlonWorkouts(completion: @escaping (Result<[String: [HKWorkout]], Error>) -> Void) {
        let group = DispatchGroup()
        var workouts: [String: [HKWorkout]] = ["swim": [], "bike": [], "run": []]
        var fetchError: Error?
        
        // Swim
        group.enter()
        fetchWorkoutsByType(.swimming) { result in
            switch result {
            case .success(let w): workouts["swim"] = w
            case .failure(let e): fetchError = e
            }
            group.leave()
        }
        
        // Bike
        group.enter()
        fetchWorkoutsByType(.cycling) { result in
            switch result {
            case .success(let w): workouts["bike"] = w
            case .failure(let e): fetchError = e
            }
            group.leave()
        }
        
        // Run
        group.enter()
        fetchWorkoutsByType(.running) { result in
            switch result {
            case .success(let w): workouts["run"] = w
            case .failure(let e): fetchError = e
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
    
    func fetchWorkoutStats(for workout: HKWorkout,
                           completion: @escaping (Result<WorkoutStats, Error>) -> Void) {
        let group = DispatchGroup()
        var stats = WorkoutStats()
        var fetchError: Error?
        
        // Heart Rate
        if let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) {
            group.enter()
            let predicate = HKQuery.predicateForSamples(
                withStart: workout.startDate, end: workout.endDate, options: .strictStartDate
            )
            let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate,
                                          options: [.discreteAverage, .discreteMin, .discreteMax]) { _, statistics, error in
                defer { group.leave() }
                if let error = error {
                    fetchError = error
                    return
                }
                let hrUnit = HKUnit.count().unitDivided(by: .minute())
                stats.averageHeartRate = statistics?.averageQuantity()?.doubleValue(for: hrUnit)
                stats.minHeartRate = statistics?.minimumQuantity()?.doubleValue(for: hrUnit)
                stats.maxHeartRate = statistics?.maximumQuantity()?.doubleValue(for: hrUnit)
            }
            healthStore.execute(query)
        }
        
        // Energy Burned
        if let energyType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) {
            group.enter()
            let predicate = HKQuery.predicateForSamples(
                withStart: workout.startDate, end: workout.endDate, options: .strictStartDate
            )
            let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate,
                                          options: .cumulativeSum) { _, statistics, error in
                defer { group.leave() }
                if let error = error {
                    fetchError = error
                    return
                }
                stats.totalEnergyBurned = statistics?.sumQuantity()?.doubleValue(for: .kilocalorie())
            }
            healthStore.execute(query)
        }
        
        // Stroke Count if Swim
        if workout.workoutActivityType == .swimming,
           let strokeType = HKObjectType.quantityType(forIdentifier: .swimmingStrokeCount) {
            group.enter()
            let predicate = HKQuery.predicateForSamples(
                withStart: workout.startDate, end: workout.endDate, options: .strictStartDate
            )
            let query = HKStatisticsQuery(quantityType: strokeType, quantitySamplePredicate: predicate,
                                          options: .cumulativeSum) { _, statistics, error in
                defer { group.leave() }
                if let error = error {
                    fetchError = error
                    return
                }
                stats.strokeCount = statistics?.sumQuantity()?.doubleValue(for: .count())
            }
            healthStore.execute(query)
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
    
    struct WorkoutStats {
        var duration: TimeInterval = 0
        var totalDistance: Double?
        var totalEnergyBurned: Double?
        var averageHeartRate: Double?
        var minHeartRate: Double?
        var maxHeartRate: Double?
        var strokeCount: Double?
    }
    
    enum HealthError: Error {
        case notAvailable
        case authorizationDenied
        case dataTypeUnavailable
    }
}

