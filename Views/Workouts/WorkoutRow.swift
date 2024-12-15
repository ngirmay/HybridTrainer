import SwiftUI
import Models

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: workout.type.icon)
                    .foregroundStyle(workout.type.displayColor)
                Text(workout.startDate.formatted(date: .abbreviated, time: .shortened))
                Spacer()
                Text(formatDuration(workout.duration))
            }
            if let distance = workout.distance {
                Text(String(format: "%.1f km", distance / 1000))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return String(format: "%d:%02d", hours, minutes)
    }
}

#Preview {
    WorkoutRow(workout: Workout(
        type: .run,
        startDate: Date(),
        duration: 3600,
        distance: 10000
    ))
} 