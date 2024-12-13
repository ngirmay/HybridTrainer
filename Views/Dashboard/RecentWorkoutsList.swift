//
//  RecentWorkoutsList.swift
//  HybridTrainer
//

import SwiftUI

struct RecentWorkoutsList: View {
    let workouts: [Workout]
    var selectedSport: WorkoutType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workouts")
                .font(.headline)
            
            let filteredWorkouts = selectedSport != nil ?
                workouts.filter { $0.type == selectedSport } :
                workouts
            
            if filteredWorkouts.isEmpty {
                Text("No recent workouts")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(filteredWorkouts.prefix(5)) { workout in
                    WorkoutRow(workout: workout)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    RecentWorkoutsList(workouts: [])
}
