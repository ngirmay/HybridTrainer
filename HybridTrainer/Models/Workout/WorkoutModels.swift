import Foundation
import CoreLocation
import HealthKit

public struct WorkoutDetails: Identifiable {
    public let id: String
    public let workout: HKWorkout
    public let heartRateData: [HeartRateSample]
    public let splits: [Split]
    public let route: [LocationSample]?
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

public struct LocationSample: Codable, Identifiable {
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
}

// MARK: - Sample Data
public extension WorkoutDetails {
    static let sampleData = WorkoutDetails(
        id: UUID().uuidString,
        workout: HKWorkout(
            activityType: .running,
            start: Date().addingTimeInterval(-3600),
            end: Date(),
            duration: 3600,
            totalEnergyBurned: HKQuantity(unit: .kilocalorie(), doubleValue: 450),
            totalDistance: HKQuantity(unit: .mile(), doubleValue: 5),
            metadata: nil
        ),
        heartRateData: [
            HeartRateSample(timestamp: Date(), value: 150),
            HeartRateSample(timestamp: Date().addingTimeInterval(60), value: 155)
        ],
        splits: [
            Split(distance: 1.0, duration: 480, pace: 8.0),
            Split(distance: 1.0, duration: 485, pace: 8.08)
        ],
        route: [
            LocationSample(
                timestamp: Date(),
                coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                altitude: 0
            )
        ]
    )
} 