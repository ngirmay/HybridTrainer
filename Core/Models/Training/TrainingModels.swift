import SwiftData
import Foundation
import SwiftUI

/// Core training models and enums for the HybridTrainer app
public enum WorkoutType: String, Codable {
    case run, bike, swim, strength, yoga, other, triathlon
    
    public var icon: String {
        switch self {
        case .run: return "figure.run"
        case .bike: return "bicycle"
        case .swim: return "figure.pool.swim"
        case .strength: return "dumbbell.fill"
        case .yoga: return "figure.mind.and.body"
        case .triathlon: return "figure.outdoor.cycle"
        case .other: return "figure.mixed.cardio"
        }
    }
    
    public var displayColor: Color {
        switch self {
        case .run: return .blue
        case .bike: return .green
        case .swim: return .cyan
        case .strength: return .orange
        case .yoga: return .purple
        case .triathlon: return .indigo
        case .other: return .gray
        }
    }
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
    
    // For backward compatibility
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
    public var workoutDescription: String  // Changed from description
    public var intensity: WorkoutIntensity
    public var targetDistance: Double?
    public var targetDuration: TimeInterval?
    public var targetPace: Double?
    public var isCompleted: Bool
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        workoutDescription: String,
        intensity: WorkoutIntensity,
        targetDistance: Double? = nil,
        targetDuration: TimeInterval? = nil,
        targetPace: Double? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.type = type
        self.workoutDescription = workoutDescription
        self.intensity = intensity
        self.targetDistance = targetDistance
        self.targetDuration = targetDuration
        self.targetPace = targetPace
        self.isCompleted = isCompleted
    }
}

@Model
public final class TrainingWeek {
    // Move implementation from Models/Training/TrainingWeek.swift
}

// ... other models 