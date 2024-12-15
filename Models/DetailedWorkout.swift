import Foundation
import CoreLocation

public struct DetailedWorkout: Identifiable {
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
}

public struct HeartRatePoint: Identifiable {
    public let id: UUID
    public let timestamp: Date
    public let value: Double
    
    public init(timestamp: Date, value: Double) {
        self.id = UUID()
        self.timestamp = timestamp
        self.value = value
    }
}

public struct LocationPoint: Identifiable {
    public let id: UUID
    public let timestamp: Date
    public let coordinate: CLLocationCoordinate2D
    public let elevation: Double?
    
    public init(timestamp: Date, coordinate: CLLocationCoordinate2D, elevation: Double? = nil) {
        self.id = UUID()
        self.timestamp = timestamp
        self.coordinate = coordinate
        self.elevation = elevation
    }
} 