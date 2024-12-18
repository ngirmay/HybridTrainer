import Foundation
import HealthKit
import SwiftUI

public enum WorkoutType: String, Codable, CaseIterable {
    case run
    case bike
    case swim
    case triathlon
    
    var icon: String {
        switch self {
        case .run: return "figure.run"
        case .bike: return "bicycle"
        case .swim: return "figure.pool.swim"
        case .triathlon: return "flag.filled.and.flag.crossed"
        }
    }
    
    var displayColor: Color {
        switch self {
        case .run: return Theme.Colors.run
        case .bike: return Theme.Colors.bike
        case .swim: return Theme.Colors.swim
        case .triathlon: return Theme.Colors.accent
        }
    }
} 