//
//  WorkoutViews.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

// Views/Workouts/WorkoutViews.swift
import SwiftUI
import SwiftData
import Models

public struct WorkoutsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Workout.startDate, order: .reverse) private var workouts: [Workout]
    
    public init() {}
    
    public var body: some View {
        List {
            ForEach(workouts) { workout in
                WorkoutRow(workout: workout)
            }
        }
        .navigationTitle("Workouts")
    }
}

#Preview {
    WorkoutsView()
        .modelContainer(for: [Workout.self], inMemory: true)
}

