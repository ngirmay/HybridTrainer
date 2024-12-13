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

#Preview {
    RecentWorkoutsList(workouts: [])
}
