//
//  HealthKitManager.swift
//  HybridTrainer
//

import HealthKit
import Foundation
import Models

enum HealthKitError: Error {
    case authorizationDenied
    case dataNotAvailable
    case invalidData
}

class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()
    
    private let typesToRead: Set<HKObjectType> = [
        HKObjectType.workoutType(),
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
        HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
        HKSeriesType.workoutRoute(),
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)!
    ]
    
    private init() {}
    
    func requestAuthorization() async throws {
        try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
    }
    
    func fetchWorkouts(from startDate: Date? = nil) async throws -> [DetailedWorkout] {
        let workoutType = HKObjectType.workoutType()
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let predicate: NSPredicate
        if let startDate = startDate {
            predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        } else {
            predicate = HKQuery.predicateForSamples(withStart: Date.distantPast, end: Date())
        }
        
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
                    continuation.resume(throwing: HealthKitError.invalidData)
                    return
                }
                
                continuation.resume(returning: workouts)
            }
            
            healthStore.execute(query)
        }
        
        return try await withThrowingTaskGroup(of: DetailedWorkout.self) { group in
            for hkWorkout in workouts {
                group.addTask {
                    async let heartRate = self.fetchHeartRateData(for: hkWorkout)
                    async let route = self.fetchRouteData(for: hkWorkout)
                    
                    let workout = Workout(
                        type: WorkoutType.from(healthKitType: hkWorkout.workoutActivityType),
                        startDate: hkWorkout.startDate,
                        duration: hkWorkout.duration,
                        distance: hkWorkout.totalDistance?.doubleValue(for: .meter()),
                        calories: hkWorkout.totalEnergyBurned?.doubleValue(for: .kilocalorie())
                    )
                    
                    return DetailedWorkout(
                        workout: workout,
                        heartRateData: try await heartRate,
                        routeData: try await route
                    )
                }
            }
            
            var detailedWorkouts: [DetailedWorkout] = []
            for try await workout in group {
                detailedWorkouts.append(workout)
            }
            
            return detailedWorkouts.sorted { $0.workout.startDate > $1.workout.startDate }
        }
    }
    
    private func fetchHeartRateData(for workout: HKWorkout) async throws -> [HeartRatePoint] {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let predicate = HKQuery.predicateForSamples(
            withStart: workout.startDate,
            end: workout.endDate,
            options: .strictStartDate
        )
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let heartRateSamples = samples as? [HKQuantitySample] else {
                    continuation.resume(returning: [])
                    return
                }
                
                let heartRatePoints = heartRateSamples.map { sample in
                    HeartRatePoint(
                        timestamp: sample.startDate,
                        value: sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                    )
                }
                
                continuation.resume(returning: heartRatePoints)
            }
            
            healthStore.execute(query)
        }
    }
    
    private func fetchRouteData(for workout: HKWorkout) async throws -> [LocationPoint] {
        // Implementation for route data fetching
        // This is a placeholder - would need to implement full route querying
        return []
    }
}

// Supporting types
struct HeartRatePoint: Identifiable {
    let id = UUID()
    let timestamp: Date
    let value: Double
}

struct LocationPoint: Identifiable {
    let id = UUID()
    let timestamp: Date
    let coordinate: CLLocationCoordinate2D
    let elevation: Double?
}

struct DetailedWorkout: Identifiable {
    let id = UUID()
    let workout: Workout
    let heartRateData: [HeartRatePoint]
    let routeData: [LocationPoint]
}

