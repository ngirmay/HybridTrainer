import Foundation
import HealthKit

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