//
//  WorkoutRow.swift
//  HybridTrainer
//

import SwiftUI

struct WorkoutRow: View {
    let workout: Workout
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.type.rawValue.capitalized)
                    .font(.headline)
                
                Text(dateFormatter.string(from: workout.date))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                if workout.distance > 0 {
                    Text(String(format: "%.1f km", workout.distance/1000))
                }
                Text(String(format: "%.0f min", workout.duration/60))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}
