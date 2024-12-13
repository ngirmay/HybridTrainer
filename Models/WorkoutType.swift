import Foundation

enum WorkoutType: String, Codable {
    case swim
    case bike
    case run
    case strength
    
    var icon: String {
        switch self {
        case .swim: return "figure.pool.swim"
        case .bike: return "bicycle"
        case .run: return "figure.run"
        case .strength: return "figure.strengthtraining.traditional"
        }
    }
} 