import Foundation
import CoreLocation
import HealthKit

// MARK: - Data Models
struct HeartRateSample: Codable, Identifiable {
    let id: UUID
    let timestamp: Date
    let value: Double
    
    init(id: UUID, timestamp: Date, value: Double) {
        self.id = id
        self.timestamp = timestamp
        self.value = value
    }
}

struct Split: Codable, Identifiable {
    let id: UUID
    let distance: Double
    let duration: TimeInterval
    let pace: Double
    
    init(id: UUID, distance: Double, duration: TimeInterval, pace: Double) {
        self.id = id
        self.distance = distance
        self.duration = duration
        self.pace = pace
    }
}

struct LocationSample: Codable, Identifiable, Equatable {
    let id: UUID
    let timestamp: Date
    private let latitude: Double
    private let longitude: Double
    let altitude: Double?
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(id: UUID, timestamp: Date, coordinate: CLLocationCoordinate2D, altitude: Double?) {
        self.id = id
        self.timestamp = timestamp
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.altitude = altitude
    }
    
    static func == (lhs: LocationSample, rhs: LocationSample) -> Bool {
        lhs.id == rhs.id
    }
}

struct WorkoutDetails {
    let workout: HKWorkout
    let heartRateData: [HeartRateSample]
    let splits: [Split]
    let route: [LocationSample]?
}

struct DailyHealthData: Codable {
    let date: Date
    let stepCount: Int
    let heartRateSamples: [HeartRateSample]
    let averageHeartRate: Double
} 