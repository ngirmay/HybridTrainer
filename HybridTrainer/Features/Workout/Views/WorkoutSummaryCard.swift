import SwiftUI
import HealthKit

struct WorkoutSummaryCard: View {
    let workout: HKWorkout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Workout Type
            HStack {
                Image(systemName: workoutIcon)
                    .font(.title2)
                Text(workout.workoutActivityType.name)
                    .font(.headline)
                Spacer()
                Text(workout.startDate.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Stats
            HStack(spacing: 20) {
                StatView(
                    title: "Duration",
                    value: formatDuration(workout.duration)
                )
                
                if let distance = workout.totalDistance?.doubleValue(for: .mile()) {
                    StatView(
                        title: "Distance",
                        value: String(format: "%.1f mi", distance)
                    )
                }
                
                if let calories = workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) {
                    StatView(
                        title: "Calories",
                        value: String(format: "%.0f", calories)
                    )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    private var workoutIcon: String {
        switch workout.workoutActivityType {
        case .running: return "figure.run"
        case .cycling: return "figure.outdoor.cycle"
        case .swimming: return "figure.pool.swim"
        case .walking: return "figure.walk"
        case .hiking: return "figure.hiking"
        case .yoga: return "figure.yoga"
        case .functionalStrengthTraining, .traditionalStrengthTraining:
            return "figure.strengthtraining.traditional"
        default: return "figure.mixed.cardio"
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: duration) ?? ""
    }
}

private struct StatView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.system(.body, design: .rounded))
                .bold()
        }
    }
} 