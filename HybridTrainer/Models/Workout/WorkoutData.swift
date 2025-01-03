import HealthKit

struct WorkoutData: Codable {
    let id: String
    let type: String
    let startDate: Date
    let endDate: Date
    let duration: TimeInterval
    let distance: Double?
    let energyBurned: Double?
    let heartRate: Double?
    var synced: Bool = false
    
    init(from workout: HKWorkout) {
        self.id = workout.uuid.uuidString
        self.type = workout.workoutActivityType.name
        self.startDate = workout.startDate
        self.endDate = workout.endDate
        self.duration = workout.duration
        self.distance = workout.totalDistance?.doubleValue(for: .mile())
        self.energyBurned = workout.totalEnergyBurned?.doubleValue(for: .kilocalorie())
        self.heartRate = nil // This would come from samples
    }
} 