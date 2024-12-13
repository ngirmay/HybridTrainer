//
//  TrainingSession.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
final class TrainingSession {
    var id: UUID
    var date: Date
    var workouts: [Workout]
    var type: SessionType
    var notes: String?
    var readinessScore: Int?
    var recoveryStatus: RecoveryStatus
    
    init(date: Date = Date(), workouts: [Workout] = [], type: SessionType) {
        self.id = UUID()
        self.date = date
        self.workouts = workouts
        self.type = type
        self.recoveryStatus = .fresh
    }
    
    var totalDuration: TimeInterval {
        workouts.reduce(0) { $0 + $1.duration }
    }
}

enum SessionType: String, Codable {
    case endurance
    case speed
    case recovery
    case brick
    case race
    
    var icon: String {
        switch self {
        case .endurance: return "infinity"
        case .speed: return "bolt.fill"
        case .recovery: return "heart.fill"
        case .brick: return "circle.grid.2x2.fill"
        case .race: return "flag.checkered"
        }
    }
}

enum RecoveryStatus: String, Codable {
    case fresh
    case moderate
    case tired
    case overreaching
    
    var color: String {
        switch self {
        case .fresh: return "green"
        case .moderate: return "yellow"
        case .tired: return "orange"
        case .overreaching: return "red"
        }
    }
}

