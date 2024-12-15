import Foundation
import HealthKit
import SwiftUI

public enum WorkoutType: String, Codable, Hashable, CaseIterable {
    case run, bike, swim, strength
    
    public var icon: String {
        switch self {
        case .swim: return "figure.pool.swim"
        case .bike: return "bicycle"
        case .run: return "figure.run"
        case .strength: return "figure.strengthtraining.traditional"
        }
    }
    
    public var color: Color {
        switch self {
        case .swim: return .blue
        case .bike: return .green
        case .run: return .orange
        case .strength: return .purple
        }
    }
    
    var healthKitType: HKWorkoutActivityType {
        switch self {
        case .run: return .running
        case .bike: return .cycling
        case .swim: return .swimming
        case .strength: return .traditionalStrengthTraining
        }
    }
    
    var metrics: Set<WorkoutMetric> {
        switch self {
        case .run, .bike: return [.distance, .pace, .heartRate]
        case .swim: return [.distance, .strokeCount, .heartRate]
        case .strength: return [.repetitions, .weight, .heartRate]
        }
    }
    
    public static func from(healthKitType: HKWorkoutActivityType) -> WorkoutType {
        switch healthKitType {
        case .swimming: return .swim
        case .cycling: return .bike
        case .running: return .run
        case .traditionalStrengthTraining: return .strength
        default: return .run
        }
    }
} 