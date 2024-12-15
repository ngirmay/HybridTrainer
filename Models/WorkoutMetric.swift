import Foundation

public enum WorkoutMetric: String, Codable, Hashable {
    case distance
    case pace
    case heartRate
    case strokeCount
    case repetitions
    case weight
    
    var unit: String {
        switch self {
        case .distance: return "km"
        case .pace: return "min/km"
        case .heartRate: return "bpm"
        case .strokeCount: return "strokes"
        case .repetitions: return "reps"
        case .weight: return "kg"
        }
    }
    
    var displayName: String {
        switch self {
        case .distance: return "Distance"
        case .pace: return "Pace"
        case .heartRate: return "Heart Rate"
        case .strokeCount: return "Stroke Count"
        case .repetitions: return "Repetitions"
        case .weight: return "Weight"
        }
    }
} 