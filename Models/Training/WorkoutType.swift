import Foundation
import SwiftUI

public enum WorkoutType: String, Codable {
    case run
    case bike
    case swim
    case strength
    case other
    
    public var icon: String {
        switch self {
        case .run: return "figure.run"
        case .bike: return "bicycle"
        case .swim: return "figure.pool.swim"
        case .strength: return "dumbbell.fill"
        case .other: return "figure.mixed.cardio"
        }
    }
    
    public var displayColor: Color {
        switch self {
        case .run: return .blue
        case .bike: return .green
        case .swim: return .cyan
        case .strength: return .orange
        case .other: return .gray
        }
    }
} 