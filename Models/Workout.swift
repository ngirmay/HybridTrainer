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
    var calories: Double
    var averageHeartRate: Double?
    var maxHeartRate: Double?
    var strokeCount: Int?
    var tss: Double?
    
    init(
        id: UUID = UUID(),
        date: Date,
        type: WorkoutType,
        duration: TimeInterval,
        distance: Double? = nil,
        calories: Double = 0,
        averageHeartRate: Double? = nil,
        maxHeartRate: Double? = nil,
        strokeCount: Int? = nil,
        tss: Double? = nil
    ) {
        self.id = id
        self.date = date
        self.type = type
        self.duration = duration
        self.distance = distance
        self.calories = calories
        self.averageHeartRate = averageHeartRate
        self.maxHeartRate = maxHeartRate
        self.strokeCount = strokeCount
        self.tss = tss
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

