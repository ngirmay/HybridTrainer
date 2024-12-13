//
//  WorkoutViewModel.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/12/24.
//

// ViewModels/WorkoutViewModel.swift
import SwiftUI
import Charts

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var isLoading = false
    @Published var error: Error?

    let healthKitService = HealthKitService.shared

    func loadWorkouts() async {
        isLoading = true
        workouts = await healthKitService.fetchAndProcessWorkouts()
        isLoading = false
    }

    var weeklyVolume: [(week: Date, duration: TimeInterval)] {
        let calendar = Calendar.current
        let groupedWorkouts = Dictionary(grouping: workouts) { workout in
            calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: workout.date))!
        }

        return groupedWorkouts.map { (week, workouts) in
            (
                week: week,
                duration: workouts.reduce(0) { $0 + $1.duration }
            )
        }.sorted { $0.week < $1.week }
    }
}

