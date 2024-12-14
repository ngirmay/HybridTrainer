// Models/TrendDirection.swift
import SwiftUI

public enum TrendDirection {  // Make it public
    case increasing
    case decreasing
    case neutral
    
    public var label: String {  // Make properties public
        switch self {
        case .increasing:
            return "Increasing"
        case .decreasing:
            return "Decreasing"
        case .neutral:
            return "Stable"
        }
    }
    
    public var icon: String {
        switch self {
        case .increasing: return "arrow.up"
        case .decreasing: return "arrow.down"
        case .neutral: return "arrow.forward"
        }
    }
    
    public var color: Color {
        switch self {
        case .increasing: return .green
        case .decreasing: return .red
        case .neutral: return .gray
        }
    }
}