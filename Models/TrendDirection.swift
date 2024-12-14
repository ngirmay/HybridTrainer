// Models/TrendDirection.swift

import SwiftUI

enum TrendDirection {
    case increasing
    case decreasing
    case neutral
    
    var label: String {
        switch self {
        case .increasing:
            return "Increasing"
        case .decreasing:
            return "Decreasing"
        case .neutral:
            return "Stable"
        }
    }
    
    var icon: String {
        switch self {
        case .increasing: return "arrow.up"
        case .decreasing: return "arrow.down"
        case .neutral: return "arrow.forward"
        }
    }
    
    var color: Color {
        switch self {
        case .increasing: return .green
        case .decreasing: return .red
        case .neutral: return .gray
        }
    }
}