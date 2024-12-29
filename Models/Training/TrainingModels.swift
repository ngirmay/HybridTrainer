import SwiftData
import Foundation

// Base enums
public enum TrainingPhase: String, Codable {
    case base
    case build
    case speed
    case taper
}

// Core models
@Model
public final class TrainingSession {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var date: Date
    public var notes: String?
    public var isCompleted: Bool
    
    // Relationships
    @Relationship(deleteRule: .cascade) public var plannedWorkouts: [PlannedWorkout]
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
        notes: String? = nil,
        isCompleted: Bool = false,
        plannedWorkouts: [PlannedWorkout] = [],
        weekNumber: Int? = nil,
        phase: TrainingPhase? = nil,
        plannedDuration: TimeInterval? = nil,
        plannedDistance: Double? = nil
    ) {
        self.id = id
        self.type = type
        self.date = date
        self.notes = notes
        self.isCompleted = isCompleted
        self.plannedWorkouts = plannedWorkouts
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
    public var description: String
    public var intensity: WorkoutIntensity
    public var targetDistance: Double?
    public var targetDuration: TimeInterval?
    public var targetPace: Double?
    public var isCompleted: Bool
    
    // Relationship
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
        self.description = description
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
    
    // Relationship
    @Relationship(deleteRule: .cascade) public var weeks: [TrainingWeek]
    
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