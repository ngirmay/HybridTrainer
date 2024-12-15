//
//  Workout.swift
//  HybridTrainer
//

import Foundation
import SwiftData
import HealthKit

@Model
public final class Workout {
    public var id: UUID
    public var type: WorkoutType
    public var startDate: Date
    public var duration: TimeInterval
    public var distance: Double? // in meters
    public var calories: Double?
    
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

