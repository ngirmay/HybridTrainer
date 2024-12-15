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
    public var targetDistance: Double?
    public var completed: Bool
    
    public init(
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


