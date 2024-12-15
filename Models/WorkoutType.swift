import Foundation
import HealthKit
import SwiftUI

public enum WorkoutType: String, Codable, Hashable, CaseIterable {
    case swim
    case bike
    case run
    case strength
    
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
    
    public var healthKitType: HKWorkoutActivityType {
        switch self {
        case .swim: return .swimming
        case .bike: return .cycling
        case .run: return .running
        case .strength: return .traditionalStrengthTraining
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