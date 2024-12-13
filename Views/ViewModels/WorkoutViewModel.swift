//
//  WorkoutViewModel.swift
//  HybridTrainer
//

import SwiftUI

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
    
    func workouts(for type: WorkoutType?) -> [Workout] {
        guard let type = type else { return workouts }
        return workouts.filter { $0.type == type }
    }
    
    func weeklyVolume(for type: WorkoutType?) -> [(week: Date, duration: TimeInterval)] {
        let data = workouts(for: type)
        let calendar = Calendar.current
        let groupedWorkouts = Dictionary(grouping: data) { workout in
            calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: workout.date))!
        }
        
        return groupedWorkouts.map { (week, wks) in
            (week: week, duration: wks.reduce(0) { $0 + $1.duration })
        }.sorted { $0.week < $1.week }
    }
    
    var volumeByType: [(type: WorkoutType, duration: TimeInterval)] {
        let grouped = Dictionary(grouping: workouts) { $0.type }
        return grouped.map { (type, wks) in
            (type: type, duration: wks.reduce(0) { $0 + $1.duration })
        }.sorted { $0.duration > $1.duration }
    }
    
    func averagePace(for type: WorkoutType?) -> Double? {
        let filtered = workouts(for: type)
        guard !filtered.isEmpty else { return nil }
        
        let runs = filtered.filter { $0.type == .run && $0.distance != nil && $0.distance! > 0 }
        guard !runs.isEmpty else { return nil }
        
        let totalDistance = runs.reduce(0) { $0 + ($1.distance ?? 0) } / 1000.0
        let totalTime = runs.reduce(0) { $0 + $1.duration } / 60.0
        return totalDistance > 0 ? (totalTime / totalDistance) : nil
    }
}

