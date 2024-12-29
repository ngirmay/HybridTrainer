import SwiftData
import Foundation

/// Core training models and enums for the HybridTrainer app
public enum WorkoutType: String, Codable {
    case run, bike, swim, strength, yoga, other
}

public enum WorkoutIntensity: String, Codable {
    case easy, moderate, hard, race, recovery
}

public enum TrainingPhase: String, Codable {
    case base, build, speed, taper
}

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
        phase: TrainingPhase? = nil
    ) {
        self.id = id
        self.type = type
        self.date = date
        self.plannedWorkouts = plannedWorkouts
        self.notes = notes
        self.isCompleted = isCompleted
        self.weekNumber = weekNumber
        self.phase = phase
    }
}

@Model
public final class PlannedWorkout {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var workoutDescription: String  // Changed from description
    public var intensity: WorkoutIntensity
    public var targetDistance: Double?
    public var targetDuration: TimeInterval?
    public var targetPace: Double?
    public var isCompleted: Bool
    
    // ... rest of implementation
}

// ... other models 