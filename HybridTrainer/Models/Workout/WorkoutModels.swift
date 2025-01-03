import Foundation
import CoreLocation
import HealthKit

// MARK: - Data Models
public struct HeartRateSample: Codable, Identifiable {
    public let id: UUID
    public let timestamp: Date
    public let value: Double
    
    public init(id: UUID = UUID(), timestamp: Date, value: Double) {
        self.id = id
        self.timestamp = timestamp
        self.value = value
    }
}

public struct Split: Codable, Identifiable {
    public let id: UUID
    public let distance: Double
    public let duration: TimeInterval
    public let pace: Double
    
    public init(id: UUID = UUID(), distance: Double, duration: TimeInterval, pace: Double) {
        self.id = id
        self.distance = distance
        self.duration = duration
        self.pace = pace
    }
}

public struct LocationSample: Codable, Identifiable, Equatable {
    public let id: UUID
    public let timestamp: Date
    private let latitude: Double
    private let longitude: Double
    public let altitude: Double?
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public init(id: UUID = UUID(), timestamp: Date, coordinate: CLLocationCoordinate2D, altitude: Double?) {
        self.id = id
        self.timestamp = timestamp
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.altitude = altitude
    }
    
    public static func == (lhs: LocationSample, rhs: LocationSample) -> Bool {
        lhs.id == rhs.id
    }
}

public struct WorkoutDetails {
    public let workout: HKWorkout
    public let heartRateData: [HeartRateSample]
    public let splits: [Split]
    public let route: [LocationSample]?
    
    public init(workout: HKWorkout, heartRateData: [HeartRateSample], splits: [Split], route: [LocationSample]?) {
        self.workout = workout
        self.heartRateData = heartRateData
        self.splits = splits
        self.route = route
    }
}

public struct DailyHealthData: Codable {
    public let date: Date
    public let stepCount: Int
    public let heartRateSamples: [HeartRateSample]
    public let averageHeartRate: Double
    
    public init(date: Date, stepCount: Int, heartRateSamples: [HeartRateSample], averageHeartRate: Double) {
        self.date = date
        self.stepCount = stepCount
        self.heartRateSamples = heartRateSamples
        self.averageHeartRate = averageHeartRate
    }
} 