import Foundation

struct HeartRateSample: Codable {
    let timestamp: Date
    let beatsPerMinute: Double
}

struct DailyHealthData: Codable {
    let date: Date
    let stepCount: Int
    let heartRateSamples: [HeartRateSample]
    let averageHeartRate: Double
} 