enum TrainingPhase: String, Codable {
    case base
    case build
    case speed
    case taper
}

struct TrainingBlock: Identifiable, Codable {
    let id: UUID
    let phase: TrainingPhase
    let startDate: Date
    let endDate: Date
    let focus: String // e.g., "Swim (Adaption Strength)"
    let targetWeight: Double?
    let targetBodyFat: Double?
}

struct TrainingWeek: Identifiable, Codable {
    let id: UUID
    let blockId: UUID
    let weekNumber: Int
    let startDate: Date
    let sessions: [TrainingDay]
    let metrics: WeeklyMetrics
}

struct TrainingDay: Identifiable, Codable {
    let id: UUID
    let date: Date
    let workouts: [PlannedWorkout]
    let notes: String?
}

struct PlannedWorkout: Identifiable, Codable {
    let id: UUID
    let type: WorkoutType
    let description: String // e.g., "Swim 2 - Strength"
    let intensity: WorkoutIntensity
    let targetDistance: Double?
    let targetDuration: TimeInterval?
    let targetPace: Double?
    let isCompleted: Bool
}

struct WeeklyMetrics: Codable {
    let runMileage: Double?
    let bikeMileage: Double?
    let swimMileage: Double?
    let isClean: Bool // Clean vs Dirty week
} 