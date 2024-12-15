//
//  Workout.swift
//  HybridTrainer
//

import Foundation

public struct Workout: Identifiable {
    public let id: UUID
    public let type: WorkoutType
    public let startDate: Date
    public let duration: TimeInterval
    public let distance: Double? // in meters
    public let calories: Double?
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        startDate: Date,
        duration: TimeInterval,
        distance: Double? = nil,
        calories: Double? = nil
    ) {
        self.id = id
        self.type = type
        self.startDate = startDate
        self.duration = duration
        self.distance = distance
        self.calories = calories
    }
}

