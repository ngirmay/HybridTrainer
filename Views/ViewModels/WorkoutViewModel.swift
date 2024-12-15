//
//  WorkoutViewModel.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData
import Models

@MainActor
final class WorkoutViewModel: ObservableObject {
    @Published private(set) var workouts: [Workout] = []
    @Published private(set) var weeklyVolumes: [WeeklyVolume] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let descriptor = FetchDescriptor<Workout>(sortBy: [SortDescriptor(\Workout.startDate, order: .reverse)])
            workouts = try modelContext.fetch(descriptor)
            await calculateWeeklyVolumes()
        } catch {
            self.error = error
        }
    }
    
    private func calculateWeeklyVolumes() async {
        let calendar = Calendar.current
        let groupedByWeek = Dictionary(grouping: workouts) { workout in
            calendar.startOfWeek(for: workout.startDate)
        }
        
        weeklyVolumes = groupedByWeek.map { (week, workouts) in
            WeeklyVolume(
                week: week,
                swimHours: workouts.filter { $0.type == .swim }.reduce(0) { $0 + $1.duration / 3600 },
                bikeHours: workouts.filter { $0.type == .bike }.reduce(0) { $0 + $1.duration / 3600 },
                runHours: workouts.filter { $0.type == .run }.reduce(0) { $0 + $1.duration / 3600 }
            )
        }.sorted { $0.week > $1.week }
    }
}

