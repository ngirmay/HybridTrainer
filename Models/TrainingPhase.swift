import SwiftData
import Foundation

@Model
public final class TrainingBlock {
    @Attribute(.unique) public let id: UUID
    public var phase: TrainingPhase
    public var startDate: Date
    public var endDate: Date
    public var focus: String
    public var targetWeight: Double?
    public var targetBodyFat: Double?
    
    public init(
        id: UUID = UUID(),
        phase: TrainingPhase,
        startDate: Date,
        endDate: Date,
        focus: String,
        targetWeight: Double? = nil,
        targetBodyFat: Double? = nil
    ) {
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

// Move these to separate files since they're now SwiftData models
@Model
public final class TrainingWeek {
    @Attribute(.unique) public let id: UUID
    public let blockId: UUID
    public let weekNumber: Int
    public let startDate: Date
    public var sessions: [TrainingDay]
    public var metrics: WeeklyMetrics
    
    public init(
        id: UUID = UUID(),
        blockId: UUID,
        weekNumber: Int,
        startDate: Date,
        sessions: [TrainingDay],
        metrics: WeeklyMetrics
    ) {
        self.id = id
        self.blockId = blockId
        self.weekNumber = weekNumber
        self.startDate = startDate
        self.sessions = sessions
        self.metrics = metrics
    }
}

@Model
public final class TrainingDay {
    @Attribute(.unique) public let id: UUID
    public let date: Date
    public var workouts: [PlannedWorkout]
    public var notes: String?
    
    public init(
        id: UUID = UUID(),
        date: Date,
        workouts: [PlannedWorkout],
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.workouts = workouts
        self.notes = notes
    }
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

@Model
public final class WeeklyMetrics {
    public var runMileage: Double?
    public var bikeMileage: Double?
    public var swimMileage: Double?
    public var isClean: Bool
    
    public init(
        runMileage: Double? = nil,
        bikeMileage: Double? = nil,
        swimMileage: Double? = nil,
        isClean: Bool = true
    ) {
        self.runMileage = runMileage
        self.bikeMileage = bikeMileage
        self.swimMileage = swimMileage
        self.isClean = isClean
    }
} 