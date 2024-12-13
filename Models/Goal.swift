//
//  Goal.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
final class Goal {
    var id: UUID
    var name: String
    var targetDate: Date
    var type: WorkoutType
    var targetDistance: Double?
    var completed: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        targetDate: Date,
        type: WorkoutType,
        targetDistance: Double? = nil,
        completed: Bool = false
    ) {
        self.id = id
        self.name = name
        self.targetDate = targetDate
        self.type = type
        self.targetDistance = targetDistance
        self.completed = completed
    }
}


