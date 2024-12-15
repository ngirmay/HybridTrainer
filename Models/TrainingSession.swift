//
//  TrainingSession.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public final class TrainingSession {
    public var id: UUID
    public var type: WorkoutType
    public var date: Date
    public var plannedDuration: TimeInterval?
    public var plannedDistance: Double?
    public var notes: String?
    public var workouts: [Workout]
    
    public init(
        type: WorkoutType,
        date: Date,
        plannedDuration: TimeInterval? = nil,
        plannedDistance: Double? = nil,
        notes: String? = nil
    ) {
        self.id = UUID()
        self.type = type
        self.date = date
        self.plannedDuration = plannedDuration
        self.plannedDistance = plannedDistance
        self.notes = notes
        self.workouts = []
    }
}

