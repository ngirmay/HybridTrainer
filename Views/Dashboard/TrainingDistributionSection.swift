//
//  TrainingDistributionSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts
import Models

struct TrainingDistributionSection: View {
    let workouts: [Workout]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Training Distribution")
                .font(.headline)
            
            if let workout = workouts.first {
                VStack(spacing: 20) {
                    // Duration Distribution
                    HStack {
                        Text("Duration")
                            .font(.subheadline)
                        Spacer()
                        Text(formatDuration(workout.duration))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    // Distance if available
                    if let distance = workout.distance {
                        HStack {
                            Text("Distance")
                                .font(.subheadline)
                            Spacer()
                            Text(String(format: "%.1f km", distance / 1000))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            } else {
                Text("No workout data available")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return String(format: "%d:%02d", hours, minutes)
    }
}

#Preview {
    TrainingDistributionSection(workouts: [
        Workout(
            type: .run,
            startDate: Date(),
            duration: 3600,
            distance: 10000
        )
    ])
    .padding()
}
