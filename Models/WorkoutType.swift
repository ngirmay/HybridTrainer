import Foundation
import HealthKit
import SwiftUI

public enum WorkoutType: String, Codable {
    case run, bike, swim, strength
    
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
} 