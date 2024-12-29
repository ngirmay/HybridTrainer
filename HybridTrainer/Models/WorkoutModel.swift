import Foundation

struct Workout: Identifiable, Codable {
    let id: UUID
    let type: WorkoutType
    let startDate: Date
    let duration: TimeInterval
    let metrics: WorkoutMetrics
    
    enum WorkoutType: String, Codable {
        case swimming
        case cycling
        case running
        case strength
    }
}

struct WorkoutMetrics: Codable {
    let distance: Double?      // In meters
    let calories: Double?      // In kcal
    let averageHeartRate: Double? // In BPM
    // Add more metrics as needed
} 