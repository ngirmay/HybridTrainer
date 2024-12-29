//
//  Workout.swift
//  HybridTrainer
//

import Foundation
import SwiftData
import HealthKit

@Model
public final class Workout: Codable {
    @Attribute(.unique) public var id: UUID
    public var type: WorkoutType
    public var date: Date
    public var distance: Double
    public var duration: TimeInterval
    public var calories: Double
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        date: Date,
        distance: Double,
        duration: TimeInterval,
        calories: Double
    ) {
        self.id = id
        self.type = type
        self.date = date
        self.distance = distance
        self.duration = duration
        self.calories = calories
    }
    
    // Required for Codable when using @Model
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        type = try container.decode(WorkoutType.self, forKey: .type)
        date = try container.decode(Date.self, forKey: .date)
        distance = try container.decode(Double.self, forKey: .distance)
        duration = try container.decode(TimeInterval.self, forKey: .duration)
        calories = try container.decode(Double.self, forKey: .calories)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(date, forKey: .date)
        try container.encode(distance, forKey: .distance)
        try container.encode(duration, forKey: .duration)
        try container.encode(calories, forKey: .calories)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, type, date, distance, duration, calories
    }
}

