import Foundation

public struct HealthData: Codable {
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