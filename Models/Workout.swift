//
//  Workout.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
final class Workout {
    var id: UUID
    var date: Date
    var type: WorkoutType
    var duration: TimeInterval
    
    var distance: Double?
    var calories: Double?
    var averageHeartRate: Double?
    var maxHeartRate: Double?
    var notes: String?
    
    var strokeCount: Int?
    var cadence: Double?
    var elevation: Double?
    var pace: Double?
    
    init(date: Date, type: WorkoutType, duration: TimeInterval) {
        self.id = UUID()
        self.date = date
        self.type = type
        self.duration = duration
    }
}

enum WorkoutType: String, Codable {
    case swim
    case bike
    case run
    case strength
    case verticalJump
    
    var icon: String {
        switch self {
        case .swim: return "figure.pool.swim"
        case .bike: return "figure.outdoor.cycle"
        case .run: return "figure.run"
        case .strength: return "dumbbell.fill"
        case .verticalJump: return "arrow.up.circle.fill"
        }
    }
}

