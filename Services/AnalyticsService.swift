import Foundation
import Models

protocol AnalyticsServiceProtocol {
    func trackWorkoutCompleted(_ workout: DetailedWorkout)
    func trackGoalProgress(_ goal: Goal)
}

class AnalyticsService: AnalyticsServiceProtocol {
    func trackWorkoutCompleted(_ workout: DetailedWorkout) {
        // Implementation
    }
    
    func trackGoalProgress(_ goal: Goal) {
        // Implementation
    }
} 