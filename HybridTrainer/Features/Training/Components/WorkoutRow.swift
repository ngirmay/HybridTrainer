import SwiftUI

struct WorkoutRow: View {
    let workout: WorkoutData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(workout.type)
                    .font(.headline)
                Text(formatDate(workout.startDate))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if let distance = workout.distance {
                    Text(String(format: "%.1f mi", distance))
                        .font(.body)
                }
                Text(formatDuration(workout.duration))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        return String(format: "%d:%02d", hours, minutes)
    }
} 