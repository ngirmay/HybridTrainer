import HealthKit

struct WorkoutDetails {
    let workout: HKWorkout
    let heartRateData: [HeartRateSample]
    let splits: [Split]
    let route: [LocationSample]?
} 