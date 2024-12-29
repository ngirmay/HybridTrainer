import SwiftData
import Foundation

// MARK: - Base Enums
public enum TrainingPhase: String, Codable {
    case base
    case build
    case speed
    case taper
}

public enum WorkoutIntensity: String, Codable {
    case easy
    case moderate
    case hard
    case race
}

// MARK: - Core Models
@Model
public final class TrainingSession {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var date: Date
    @Relationship(deleteRule: .cascade) public var plannedWorkouts: [PlannedWorkout]
    public var notes: String?
    public var isCompleted: Bool
    public var weekNumber: Int?
    public var phase: TrainingPhase?
    
    // Backward compatibility
    public var plannedDuration: TimeInterval?
    public var plannedDistance: Double?
    
    public var title: String {
        type.rawValue.capitalized
    }
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        date: Date,
        plannedWorkouts: [PlannedWorkout] = [],
        notes: String? = nil,
        isCompleted: Bool = false,
        weekNumber: Int? = nil,
        phase: TrainingPhase? = nil,
        plannedDuration: TimeInterval? = nil,
        plannedDistance: Double? = nil
    ) {
        self.id = id
        self.type = type
        self.date = date
        self.plannedWorkouts = plannedWorkouts
        self.notes = notes
        self.isCompleted = isCompleted
        self.weekNumber = weekNumber
        self.phase = phase
        self.plannedDuration = plannedDuration
        self.plannedDistance = plannedDistance
    }
}

@Model
public final class PlannedWorkout {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var workoutDescription: String
    public var intensity: WorkoutIntensity
    public var targetDistance: Double?
    public var targetDuration: TimeInterval?
    public var targetPace: Double?
    public var isCompleted: Bool
    
    @Relationship(inverse: \TrainingSession.plannedWorkouts)
    public var session: TrainingSession?
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        description: String,
        intensity: WorkoutIntensity,
        targetDistance: Double? = nil,
        targetDuration: TimeInterval? = nil,
        targetPace: Double? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.type = type
        self.workoutDescription = description
        self.intensity = intensity
        self.targetDistance = targetDistance
        self.targetDuration = targetDuration
        self.targetPace = targetPace
        self.isCompleted = isCompleted
    }
}

@Model
public final class TrainingBlock {
    @Attribute(.unique) public var id: UUID
    public var phase: TrainingPhase
    public var startDate: Date
    public var endDate: Date
    public var focus: String
    public var targetWeight: Double?
    public var targetBodyFat: Double?
    
    @Relationship(deleteRule: .cascade) 
    public var weeks: [TrainingWeek]
    
    public init(
        id: UUID = UUID(),
        phase: TrainingPhase,
        startDate: Date,
        endDate: Date,
        focus: String,
        targetWeight: Double? = nil,
        targetBodyFat: Double? = nil,
        weeks: [TrainingWeek] = []
    ) {
        self.id = id
        self.phase = phase
        self.startDate = startDate
        self.endDate = endDate
        self.focus = focus
        self.targetWeight = targetWeight
        self.targetBodyFat = targetBodyFat
        self.weeks = weeks
    }
}

@Model
public final class TrainingWeek {
    @Attribute(.unique) public var id: UUID
    public var blockId: UUID
    public var weekNumber: Int
    public var startDate: Date
    @Relationship(deleteRule: .cascade) public var sessions: [TrainingDay]
    @Relationship public var metrics: WeeklyMetrics?
    
    public init(
        id: UUID = UUID(),
        blockId: UUID,
        weekNumber: Int,
        startDate: Date,
        sessions: [TrainingDay] = [],
        metrics: WeeklyMetrics? = nil
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
    @Attribute(.unique) public var id: UUID
    public var date: Date
    @Relationship(deleteRule: .cascade) public var workouts: [PlannedWorkout]
    public var notes: String?
    
    public init(
        id: UUID = UUID(),
        date: Date,
        workouts: [PlannedWorkout] = [],
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.workouts = workouts
        self.notes = notes
    }
}

@Model
public final class WeeklyMetrics {
    @Attribute(.unique) public var id: UUID
    public var runMileage: Double?
    public var bikeMileage: Double?
    public var swimMileage: Double?
    public var isClean: Bool
    
    @Relationship(inverse: \TrainingWeek.metrics)
    public var week: TrainingWeek?
    
    public init(
        id: UUID = UUID(),
        runMileage: Double? = nil,
        bikeMileage: Double? = nil,
        swimMileage: Double? = nil,
        isClean: Bool = true
    ) {
        self.id = id
        self.runMileage = runMileage
        self.bikeMileage = bikeMileage
        self.swimMileage = swimMileage
        self.isClean = isClean
    }
} 