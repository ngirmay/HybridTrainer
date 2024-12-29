//
//  TrainingSession.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public final class TrainingSession {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var date: Date
    public var plannedWorkouts: [PlannedWorkout]
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
    public var description: String
    public var intensity: WorkoutIntensity
    public var targetDistance: Double?
    public var targetDuration: TimeInterval?
    public var targetPace: Double?
    public var isCompleted: Bool
    
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

