import Foundation
import HealthKit

public struct WorkoutData: Codable, Identifiable {
    public let id: String
    public let type: String
    public let startDate: Date
    public let endDate: Date
    public let duration: TimeInterval
    public let distance: Double?
    public let energyBurned: Double?
    public let heartRate: Double?
    public var synced: Bool = false
    
    public init(from workout: HKWorkout) {
        self.id = workout.uuid.uuidString
        self.type = workout.workoutActivityType.name
        self.startDate = workout.startDate
        self.endDate = workout.endDate
        self.duration = workout.duration
        self.distance = workout.totalDistance?.doubleValue(for: .mile())
        self.energyBurned = workout.totalEnergyBurned?.doubleValue(for: .kilocalorie())
        self.heartRate = nil // This would come from samples
    }
    
    public init(
        id: String,
        type: String,
        startDate: Date,
        endDate: Date,
        duration: TimeInterval,
        distance: Double?,
        energyBurned: Double?,
        heartRate: Double?,
        synced: Bool = false
    ) {
        self.id = id
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.distance = distance
        self.energyBurned = energyBurned
        self.heartRate = heartRate
        self.synced = synced
    }
} 