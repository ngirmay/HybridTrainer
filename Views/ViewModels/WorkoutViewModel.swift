//
//  WorkoutViewModel.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var weeklyVolumes: [WeeklyVolume] = []
    @Published var trainingLoad: [TrainingLoad] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadData()
    }
    
    func loadData() {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let descriptor = FetchDescriptor<Workout>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            self.workouts = try modelContext.fetch(descriptor)
            calculateAggregateMetrics()
        } catch {
            self.error = error
        }
    }
    
    private func calculateAggregateMetrics() {
        calculateWeeklyVolumes()
        calculateTrainingLoad()
    }
    
    private func calculateWeeklyVolumes() {
        let calendar = Calendar.current
        let groupedByWeek = Dictionary(grouping: workouts) { workout in
            calendar.startOfWeek(for: workout.date)
        }
        
        weeklyVolumes = groupedByWeek.map { (week, workouts) in
            WeeklyVolume(
                week: week,
                swimHours: workouts.filter { $0.type == .swim }.reduce(0) { $0 + $1.duration / 3600 },
                bikeHours: workouts.filter { $0.type == .bike }.reduce(0) { $0 + $1.duration / 3600 },
                runHours: workouts.filter { $0.type == .run }.reduce(0) { $0 + $1.duration / 3600 },
                totalTSS: workouts.compactMap { $0.tss }.reduce(0, +)
            )
        }.sorted { $0.week > $1.week }
    }
    
    private func calculateTrainingLoad() {
        let calendar = Calendar.current
        let today = Date()
        var loads: [TrainingLoad] = []
        
        for dayOffset in 0...42 {
            let date = calendar.date(byAdding: .day, value: -dayOffset, to: today)!
            let ctl = calculateExponentialAverage(days: 42, forDate: date)
            let atl = calculateExponentialAverage(days: 7, forDate: date)
            
            loads.append(TrainingLoad(date: date, ctl: ctl, atl: atl))
        }
        
        self.trainingLoad = loads.reversed()
    }
    
    private func calculateExponentialAverage(days: Int, forDate: Date) -> Double {
        let factor = 2.0 / Double(days + 1)
        return workouts
            .filter { Calendar.current.isDate($0.date, inSameDayAs: forDate) }
            .compactMap { $0.tss }
            .reduce(0) { acc, tss in
                acc * (1 - factor) + tss * factor
            }
    }
}

