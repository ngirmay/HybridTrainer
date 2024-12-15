import Foundation
import CoreLocation

public struct DetailedWorkout: Identifiable, Codable {
    public let id: UUID
    public let workout: Workout
    public let heartRateData: [HeartRatePoint]
    public let routeData: [LocationPoint]
    
    public init(workout: Workout, heartRateData: [HeartRatePoint], routeData: [LocationPoint]) {
        self.id = UUID()
        self.workout = workout
        self.heartRateData = heartRateData
        self.routeData = routeData
    }
    
    // Add explicit coding keys
    private enum CodingKeys: String, CodingKey {
        case id, workout, heartRateData, routeData
    }
}

public struct HeartRatePoint: Identifiable, Codable {
    public let id: UUID
    public let timestamp: Date
    public let value: Double
    
    public init(timestamp: Date, value: Double) {
        self.id = UUID()
        self.timestamp = timestamp
        self.value = value
    }
}

public struct LocationPoint: Identifiable, Codable {
    public let id: UUID
    public let timestamp: Date
    private let latitude: Double
    private let longitude: Double
    public let elevation: Double?
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public init(timestamp: Date, coordinate: CLLocationCoordinate2D, elevation: Double? = nil) {
        self.id = UUID()
        self.timestamp = timestamp
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.elevation = elevation
    }
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, latitude, longitude, elevation
    }
} 