//
//  RecentWorkoutsList.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/12/24.
//

// Views/Dashboard/RecentWorkoutsList.swift
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
                    .padding()
            } else {
                ForEach(workouts) { workout in
                    WorkoutRow(workout: workout)
                }
            }
        }
    }
}
