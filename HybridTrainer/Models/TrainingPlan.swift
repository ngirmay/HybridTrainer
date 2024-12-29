import Foundation

struct TrainingPlan: Codable {
    let phases: [Phase]
}

struct Phase: Codable {
    let name: String
    let weeks: [Week]
}

struct Week: Codable {
    let startDate: String
    let workouts: [Workout]
    let runMileage: Double?
    let bikeMileage: Double?
    let swimMileage: Double?
    let cleanOrDirty: String?
    let block: String?
    let bodyWeight: Double?
    let bodyFat: Double?
}

struct Workout: Codable {
    let dayOfWeek: String
    let description: String
} 