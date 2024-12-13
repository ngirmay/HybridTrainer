//
//  TrainingDistributionSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts

struct TrainingDistributionSection: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Training Distribution")
                .font(.headline)
            
            if let workout = viewModel.workouts.first {
                VStack(spacing: 20) {
                    // Heart Rate Zones
                    if let avgHR = workout.averageHeartRate,
                       let maxHR = workout.maxHeartRate {
                        HStack {
                            Text("Heart Rate")
                                .font(.subheadline)
                            Spacer()
                            Text("\(Int(avgHR)) bpm avg")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("•")
                                .foregroundColor(.secondary)
                            Text("\(Int(maxHR)) bpm max")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Intensity Score
                    if let intensity = workout.intensityScore {
                        HStack {
                            Text("Intensity")
                                .font(.subheadline)
                            Spacer()
                            Text(String(format: "%.2f", intensity))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            } else {
                Text("No workout data available")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
