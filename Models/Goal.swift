//
//  Goal.swift
//  HybridTrainer
//

import SwiftData
import Foundation

@Model
public final class Goal {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var targetDistance: Double
    public var targetDate: Date
    public var isCompleted: Bool
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        targetDistance: Double,
        targetDate: Date,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.type = type
        self.targetDistance = targetDistance
        self.targetDate = targetDate
        self.isCompleted = isCompleted
    }
}

// Extension for creating preset goals
extension Goal {
    public static func halfIronman(targetDate: Date) -> [Goal] {
        [
            Goal(type: .swim, targetDistance: 1.9, targetDate: targetDate),
            Goal(type: .bike, targetDistance: 90.0, targetDate: targetDate),
            Goal(type: .run, targetDistance: 21.1, targetDate: targetDate)
        ]
    }
}


