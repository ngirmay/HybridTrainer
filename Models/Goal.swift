//
//  Goal.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/10/24.
//

import Foundation
import SwiftData

@Model
final class Goal {
    var id: UUID
    var name: String
    var targetDate: Date
    var type: GoalType
    var status: GoalStatus
    var isPrimary: Bool
    
    // Changed 'description' to 'goalDescription'
    var goalDescription: String?
    var targetValue: Double?    // e.g., distance, time, or weight
    var currentValue: Double?   // current progress
    var relatedWorkouts: [Workout]? // Link to associated workouts
    
    init(name: String, targetDate: Date, type: GoalType, isPrimary: Bool = false) {
        self.id = UUID()
        self.name = name
        self.targetDate = targetDate
        self.type = type
        self.status = .inProgress
        self.isPrimary = isPrimary
    }
    
    // Computed properties for visualization
    var progressPercentage: Double? {
        guard let target = targetValue, let current = currentValue else { return nil }
        return (current / target) * 100
    }
    
    var daysUntilTarget: Int {
        Calendar.current.dateComponents([.day], from: Date(), to: targetDate).day ?? 0
    }
}

enum GoalType: String, Codable {
    case triathlon
    case running
    case verticalJump
    case strength
    
    var icon: String {
        switch self {
        case .triathlon: return "figure.triathlon"
        case .running: return "figure.run"
        case .verticalJump: return "arrow.up.circle.fill"
        case .strength: return "dumbbell.fill"
        }
    }
}

enum GoalStatus: String, Codable {
    case notStarted
    case inProgress
    case completed
    case deferred
    
    var color: String {
        switch self {
        case .notStarted: return "gray"
        case .inProgress: return "blue"
        case .completed: return "green"
        case .deferred: return "orange"
        }
    }
}
