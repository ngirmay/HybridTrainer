//
//  Goal.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public final class Goal {
    public var id: UUID
    public var name: String
    public var targetDate: Date
    public var type: WorkoutType
    public var targetValue: Double
    public var currentValue: Double
    public var completed: Bool
    
    public init(
        id: UUID = UUID(),
        name: String,
        targetDate: Date,
        type: WorkoutType,
        targetValue: Double,
        currentValue: Double = 0,
        completed: Bool = false
    ) {
        self.id = id
        self.name = name
        self.targetDate = targetDate
        self.type = type
        self.targetValue = targetValue
        self.currentValue = currentValue
        self.completed = completed
    }
    
    public var progress: Double {
        guard targetValue > 0 else { return 0 }
        return min(currentValue / targetValue, 1.0)
    }
}


