import SwiftUI
import Models

extension WorkoutType {
    var displayColor: Color {
        switch self {
        case .swim: return Theme.Colors.swim
        case .bike: return Theme.Colors.bike
        case .run: return Theme.Colors.run
        case .strength: return Theme.Colors.strength
        }
    }
} 