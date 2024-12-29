import Foundation

struct TrainingProgram: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let duration: String
    let description: String
    let sessionDuration: String
    let level: String
    let workouts: [Workout]
    let category: ProgramCategory
}

enum ProgramCategory: String, CaseIterable {
    case endurance = "Endurance"
    case strength = "Strength"
    case hiit = "HIIT"
    case recovery = "Recovery"
    case custom = "Custom"
}

struct Workout: Identifiable {
    let id = UUID()
    let title: String
    let type: WorkoutType
    let duration: Int
    let exercises: [Exercise]
}

enum WorkoutType: String {
    case run = "Run"
    case bike = "Bike"
    case swim = "Swim"
    case strength = "Strength"
    case hiit = "HIIT"
    case recovery = "Recovery"
}

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let sets: Int
    let reps: Int
    let weight: Double?
    let duration: Int?
    let distance: Double?
    let notes: String?
} 