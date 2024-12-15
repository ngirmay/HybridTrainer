//
//  RecentWorkoutsList.swift
//  HybridTrainer
//

import SwiftUI
import Models

struct RecentWorkoutsList: View {
    let workouts: [Workout]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workouts")
                .font(.headline)
            
            if workouts.isEmpty {
                Text("No recent workouts")
                    .foregroundStyle(.secondary)
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

#Preview {
    RecentWorkoutsList(workouts: [
        Workout(
            type: .run,
            startDate: Date(),
            duration: 3600,
            distance: 10000
        )
    ])
}
