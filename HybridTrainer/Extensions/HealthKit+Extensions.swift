import HealthKit

extension HKWorkoutActivityType {
    var name: String {
        switch self {
        case .running:
            return "Running"
        case .cycling:
            return "Cycling"
        case .walking:
            return "Walking"
        case .swimming:
            return "Swimming"
        case .hiking:
            return "Hiking"
        case .yoga:
            return "Yoga"
        case .functionalStrengthTraining:
            return "Strength Training"
        case .traditionalStrengthTraining:
            return "Weight Training"
        case .crossTraining:
            return "Cross Training"
        case .mixedCardio:
            return "Mixed Cardio"
        default:
            return "Workout"
        }
    }
} 