//
//  RecentWorkoutsList.swift
//  HybridTrainer
//

import SwiftUI

struct RecentWorkoutsList: View {
    let workouts: [Workout]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workouts")
                .font(.headline)
            
            if workouts.isEmpty {
                Text("No recent workouts")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(workouts) { workout in
                    WorkoutRow(workout: workout)
                }
            }
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            Image(systemName: workout.type.icon)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(workout.title ?? workout.type.rawValue.capitalized)
                    .font(.headline)
                
                Text(workout.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let duration = workout.duration {
                Text(formatDuration(duration))
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 1)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration / 3600)
        let minutes = Int((duration.truncatingRemainder(dividingBy: 3600)) / 60)
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}

#Preview {
    RecentWorkoutsList(workouts: [])
        .padding()
}
