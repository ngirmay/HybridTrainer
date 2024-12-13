//
//  Workout.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/10/24.
//

import Foundation
import SwiftData

@Model
final class Workout {
    var id: UUID
    var date: Date
    var type: WorkoutType
    var duration: TimeInterval
    
    // Add new properties
    var distance: Double?      // in meters
    var calories: Double?
    var averageHeartRate: Double?
    var maxHeartRate: Double?
    var notes: String?
    
    // Sport-specific metrics
    var strokeCount: Int?      // Swimming
    var cadence: Double?       // Cycling/Running
    var elevation: Double?     // Cycling/Running
    var pace: Double?         // Running/Swimming
    
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
