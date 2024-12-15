//
//  TrainingSession.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public final class TrainingSession {
    public var type: WorkoutType
    public var date: Date
    public var plannedDuration: TimeInterval?
    public var plannedDistance: Double?
    public var notes: String?
    
    public var title: String {
        type.rawValue.capitalized
    }
    
    public var subtitle: String {
        if let distance = plannedDistance {
            return "\(Int(distance/1000)) km"
        } else if let duration = plannedDuration {
            return "\(Int(duration/60)) minutes"
        }
        return "No details"
    }
    
    public init(
        type: WorkoutType,
        date: Date,
        plannedDuration: TimeInterval? = nil,
        plannedDistance: Double? = nil,
        notes: String? = nil
    ) {
        self.type = type
        self.date = date
        self.plannedDuration = plannedDuration
        self.plannedDistance = plannedDistance
        self.notes = notes
    }
}

