import CoreLocation

struct HeartRateSample: Codable {
    let timestamp: Date
    let value: Double
}

struct Split: Codable {
    let distance: Double
    let duration: TimeInterval
    let pace: Double
}

struct LocationSample: Codable {
    let timestamp: Date
    private let latitude: Double
    private let longitude: Double
    let altitude: Double?
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(timestamp: Date, coordinate: CLLocationCoordinate2D, altitude: Double?) {
        self.timestamp = timestamp
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.altitude = altitude
    }
}

struct CachedWorkout: Codable {
    let id: String
    let type: String
    let startDate: Date
    let endDate: Date
    let duration: TimeInterval
    let distance: Double?
    var synced: Bool
} 