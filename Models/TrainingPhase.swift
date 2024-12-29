import SwiftData
import Foundation

@Model
public final class TrainingBlock: Identifiable, Codable {
    public let id: UUID
    public var phase: TrainingPhase
    public var startDate: Date
    public var endDate: Date
    public var focus: String
    public var targetWeight: Double?
    public var targetBodyFat: Double?
    
    public init(id: UUID = UUID(),
         phase: TrainingPhase,
         startDate: Date,
         endDate: Date,
         focus: String,
         targetWeight: Double? = nil,
         targetBodyFat: Double? = nil) {
        self.id = id
        self.phase = phase
        self.startDate = startDate
        self.endDate = endDate
        self.focus = focus
        self.targetWeight = targetWeight
        self.targetBodyFat = targetBodyFat
    }
}

// Keep as enum since it's just a type
public enum TrainingPhase: String, Codable {
    case base
    case build
    case speed
    case taper
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