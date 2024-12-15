//
//  WorkoutViews.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

// Views/Workouts/WorkoutViews.swift
import SwiftUI
import Models

struct WorkoutsView: View {
    let workouts: [Workout]
    
    var body: some View {
        List {
            ForEach(workouts) { workout in
                WorkoutRow(workout: workout)
            }
        }
        .navigationTitle("Workouts")
    }
}

#Preview {
    WorkoutsView(workouts: [
        Workout(
            type: .run,
            startDate: Date(),
            duration: 3600,
            distance: 10000
        )
    ])
}

