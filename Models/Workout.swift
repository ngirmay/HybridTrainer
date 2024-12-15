//
//  Workout.swift
//  HybridTrainer
//

import Foundation
import SwiftData
import HealthKit

@Model
public final class Workout: Codable {
    public var id: UUID
    public var type: WorkoutType
    public var startDate: Date
    public var duration: TimeInterval
    public var distance: Double? // in meters
    public var calories: Double?
    
    public init(
        id: UUID = UUID(),
        type: WorkoutType,
        startDate: Date,
        duration: TimeInterval,
        distance: Double? = nil,
        calories: Double? = nil
    ) {
        self.id = id
        self.type = type
        self.startDate = startDate
        self.duration = duration
        self.distance = distance
        self.calories = calories
    }
    
    // Required for Codable when using @Model
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        type = try container.decode(WorkoutType.self, forKey: .type)
        startDate = try container.decode(Date.self, forKey: .startDate)
        duration = try container.decode(TimeInterval.self, forKey: .duration)
        distance = try container.decodeIfPresent(Double.self, forKey: .distance)
        calories = try container.decodeIfPresent(Double.self, forKey: .calories)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(duration, forKey: .duration)
        try container.encodeIfPresent(distance, forKey: .distance)
        try container.encodeIfPresent(calories, forKey: .calories)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, type, startDate, duration, distance, calories
    }
}

