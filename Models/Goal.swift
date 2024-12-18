//
//  Goal.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public class Goal {
    public var id: UUID
    public var name: String
    public var targetDate: Date
    public var type: WorkoutType
    public var targetValue: Double
    public var currentValue: Double
    public var completed: Bool
    public var notes: String?
    
    public init(
        id: UUID = UUID(),
        name: String,
        targetDate: Date,
        type: WorkoutType,
        targetValue: Double,
        currentValue: Double = 0,
        completed: Bool = false,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.targetDate = targetDate
        self.type = type
        self.targetValue = targetValue
        self.currentValue = currentValue
        self.completed = completed
        self.notes = notes
    }
    
    public var progress: Double {
        guard targetValue > 0 else { return 0 }
        return min(currentValue / targetValue, 1.0)
    }
}

// Extension for creating preset goals
extension Goal {
    public static func halfIronman(targetDate: Date) -> [Goal] {
        [
            Goal(name: "Half Ironman Swim", targetDate: targetDate, type: .swim, targetValue: 1.9),
            Goal(name: "Half Ironman Bike", targetDate: targetDate, type: .bike, targetValue: 90.0),
            Goal(name: "Half Ironman Run", targetDate: targetDate, type: .run, targetValue: 21.1)
        ]
    }
}


