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
    var strokeCount: Int?
    var tss: Double?
    
    init(date: Date, type: WorkoutType, duration: TimeInterval) {
        self.id = UUID()
        self.date = date
        self.type = type
        self.duration = duration
    }
    
    var durationFormatted: String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return String(format: "%d:%02d", hours, minutes)
    }
    
    var distanceFormatted: String? {
        guard let distance = distance else { return nil }
        return String(format: "%.1f km", distance / 1000)
    }
    
    var intensityScore: Double {
        guard let avgHR = averageHeartRate, let maxHR = maxHeartRate else { return 0 }
        return (avgHR / maxHR) * 100
    }
}

enum WorkoutType: String, Codable {
    case swim
    case bike
    case run
    case strength
    
    var icon: String {
        switch self {
        case .swim: return "figure.pool.swim"
        case .bike: return "bicycle"
        case .run: return "figure.run"
        case .strength: return "figure.strengthtraining.traditional"
        }
    }
    
    var color: String {
        switch self {
        case .swim: return "blue"
        case .bike: return "green"
        case .run: return "orange"
        case .strength: return "purple"
        }
    }
}

