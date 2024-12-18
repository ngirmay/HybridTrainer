import Foundation
import HealthKit
import SwiftUI

public enum WorkoutType: String, Codable, Hashable, CaseIterable {
    case run, bike, swim, strength, triathlon
    
    public var icon: String {
        switch self {
        case .swim: return "figure.pool.swim"
        case .bike: return "bicycle"
        case .run: return "figure.run"
        case .strength: return "figure.strengthtraining.traditional"
        case .triathlon: return "flag.filled.and.flag.crossed"
        }
    }
    
    public var displayColor: Color {
        switch self {
        case .swim: return Theme.Colors.swim
        case .bike: return Theme.Colors.bike
        case .run: return Theme.Colors.run
        case .strength: return Theme.Colors.strength
        case .triathlon: return Theme.Colors.accent
        }
    }
    
    var healthKitType: HKWorkoutActivityType {
        switch self {
        case .run: return .running
        case .bike: return .cycling
        case .swim: return .swimming
        case .strength: return .traditionalStrengthTraining
        case .triathlon: return .mixedCardio
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