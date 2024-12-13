import SwiftUI
import SwiftData

enum WorkoutType: String, Codable, CaseIterable, PersistentEnum {
    case swim
    case bike
    case run
    case strength
    case other
    
    var icon: String {
        switch self {
        case .swim: return "figure.pool.swim"
        case .bike: return "bicycle"
        case .run: return "figure.run"
        case .strength: return "figure.strengthtraining.traditional"
        case .other: return "figure.mixed.cardio"
        }
    }
    
    var color: Color {
        switch self {
        case .swim: return .blue
        case .bike: return .green
        case .run: return .orange
        case .strength: return .purple
        case .other: return .gray
        }
    }
} 