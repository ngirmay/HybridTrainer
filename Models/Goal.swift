//
//  Goal.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public class Goal {
    public var type: WorkoutType
    public var targetDistance: Double  // in meters
    public var targetTime: TimeInterval
    public var deadline: Date
    public var isCompleted: Bool
    public var notes: String?
    public var isRaceGoal: Bool
    public var subGoals: [Goal]?
    
    public init(type: WorkoutType, 
         targetDistance: Double, 
         targetTime: TimeInterval, 
         deadline: Date,
         isRaceGoal: Bool = false,
         notes: String? = nil,
         subGoals: [Goal]? = nil) {
        self.type = type
        self.targetDistance = targetDistance
        self.targetTime = targetTime
        self.deadline = deadline
        self.isCompleted = false
        self.isRaceGoal = isRaceGoal
        self.notes = notes
        self.subGoals = subGoals
    }
}

extension Goal {
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return String(format: "%d:%02d", hours, minutes)
    }
    
    static func halfIronman(deadline: Date) -> Goal {
        let mainGoal = Goal(
            type: .triathlon,
            targetDistance: 113000, // 113km total
            targetTime: 6 * 3600,   // 6 hours
            deadline: deadline,
            isRaceGoal: true,
            notes: "Half Ironman Race Goal",
            subGoals: [
                Goal(type: .swim, targetDistance: 1900, targetTime: 45 * 60, deadline: deadline,
                     notes: "1.9km swim leg"),
                Goal(type: .bike, targetDistance: 90000, targetTime: 3 * 3600, deadline: deadline,
                     notes: "90km bike leg"),
                Goal(type: .run, targetDistance: 21100, targetTime: 2 * 3600, deadline: deadline,
                     notes: "21.1km run leg")
            ]
        )
        return mainGoal
    }
}


