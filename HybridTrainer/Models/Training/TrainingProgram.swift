import Foundation

public struct TrainingProgram: Identifiable, Codable {
    public let id: String
    public let title: String
    public let description: String
    public let duration: String
    public let icon: String
    public let workouts: [ProgramWorkout]
    
    public init(
        id: String = UUID().uuidString,
        title: String,
        description: String,
        duration: String,
        icon: String,
        workouts: [ProgramWorkout] = []
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.duration = duration
        self.icon = icon
        self.workouts = workouts
    }
}

public struct ProgramWorkout: Identifiable, Codable {
    public let id: String
    public let name: String
    public let type: WorkoutType
    public let duration: TimeInterval
    public let targetMetrics: WorkoutMetrics
    
    public init(
        id: String = UUID().uuidString,
        name: String,
        type: WorkoutType,
        duration: TimeInterval,
        targetMetrics: WorkoutMetrics
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.duration = duration
        self.targetMetrics = targetMetrics
    }
}

public enum WorkoutType: String, Codable {
    case run
    case ride
    case swim
    case strength
    case hiit
    case other
}

public struct WorkoutMetrics: Codable {
    public let distance: Double?
    public let pace: Double?
    public let heartRate: HeartRateZone?
    
    public init(distance: Double? = nil, pace: Double? = nil, heartRate: HeartRateZone? = nil) {
        self.distance = distance
        self.pace = pace
        self.heartRate = heartRate
    }
}

public struct HeartRateZone: Codable {
    public let min: Int
    public let max: Int
    
    public init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
} 