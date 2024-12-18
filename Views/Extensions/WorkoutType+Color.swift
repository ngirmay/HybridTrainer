import SwiftUI
import Models

extension WorkoutType {
    var color: Color {
        switch self {
        case .run: return .orange
        case .bike: return .green
        case .swim: return .blue
        case .strength: return .purple
        case .triathlon: return .red
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .run: return LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .bike: return LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .swim: return LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .strength: return LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .triathlon: return LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
    
    var title: String {
        switch self {
        case .run: return "Running"
        case .bike: return "Cycling"
        case .swim: return "Swimming"
        case .strength: return "Strength"
        case .triathlon: return "Triathlon"
        }
    }
} 