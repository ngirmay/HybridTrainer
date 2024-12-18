//
//  HealthKitManager.swift
//  HybridTrainer
//

import HealthKit
import Foundation
import CoreLocation
import Models

enum HealthKitError: Error {
    case authorizationDenied
    case dataNotAvailable
    case invalidData
}

class HealthKitManager {
    static let shared = HealthKitManager()
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
        let calendar = Calendar.current
        let now = Date()
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: now))!
        let predicate = HKQuery.predicateForSamples(withStart: startOfYear, end: now, options: .strictStartDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let hkWorkouts = try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: .workoutType(),
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sortDescriptor]
            ) { (query, samples, error) in
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
        
        return hkWorkouts.map { hkWorkout in
            let distance = hkWorkout.totalDistance?.doubleValue(for: HKUnit.meter())
            let calories = hkWorkout.totalEnergyBurned?.doubleValue(for: HKUnit.kilocalorie())
            
            return Workout(
                type: WorkoutType.from(healthKitType: hkWorkout.workoutActivityType),
                startDate: hkWorkout.startDate,
                duration: hkWorkout.duration,
                distance: distance,
                calories: calories
            )
        }
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

