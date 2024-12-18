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
    
    private func convertToWorkoutType(_ hkType: HKWorkoutActivityType) -> WorkoutType {
        switch hkType {
        case .running: return .run
        case .cycling: return .bike
        case .swimming: return .swim
        case .traditionalStrengthTraining: return .strength
        default: return .run
        }
    }
    
    func fetchWorkouts() async throws -> [Workout] {
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .greaterThan)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let hkWorkouts = try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: .workoutType(),
                predicate: workoutPredicate,
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
        
        // Convert HKWorkout to our Workout model
        return hkWorkouts.map { hkWorkout in
            Workout(
                type: convertToWorkoutType(hkWorkout.workoutActivityType),
                startDate: hkWorkout.startDate,
                duration: hkWorkout.duration,
                distance: hkWorkout.totalDistance?.doubleValue(for: .meter()),
                calories: hkWorkout.totalEnergyBurned?.doubleValue(for: .kilocalorie())
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

