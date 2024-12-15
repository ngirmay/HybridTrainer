//
//  DashboardView.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData
import Charts
import Models

public struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var weeklyVolumes: [WeeklyVolume]
    @Query private var workouts: [Workout]
    @Query private var goals: [Goal]
    @Query private var trainingSessions: [TrainingSession]
    
    public init() {
        let weeklySort = SortDescriptor<WeeklyVolume>(\.week, order: .reverse)
        _weeklyVolumes = Query(sort: [weeklySort])
        
        let workoutSort = SortDescriptor<Workout>(\.startDate, order: .reverse)
        _workouts = Query(sort: [workoutSort])
        
        let goalSort = SortDescriptor<Goal>(\.targetDate)
        _goals = Query(sort: [goalSort])
        
        let sessionSort = SortDescriptor<TrainingSession>(\.date, order: .reverse)
        _trainingSessions = Query(sort: [sessionSort])
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Theme.Metrics.padding) {
                    MetricsSection(workouts: workouts)
                        .padding(.horizontal)
                    
                    WeeklyVolumeSection(weeklyVolumes: weeklyVolumes)
                        .padding(.horizontal)
                    
                    ChartSection(title: "Training Load") {
                        if weeklyVolumes.isEmpty {
                            Text("No data available")
                                .foregroundStyle(.secondary)
                        } else {
                            Chart(weeklyVolumes) { volume in
                                LineMark(
                                    x: .value("Week", volume.week),
                                    y: .value("Hours", volume.swimHours + volume.bikeHours + volume.runHours)
                                )
                            }
                            .frame(height: 200)
                        }
                    }
                    .padding(.horizontal)
                    
                    RecentWorkoutsList(workouts: workouts)
                        .padding(.horizontal)
                }
                .padding()
            }
            .background(Theme.Colors.background)
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
        .modelContainer(for: [
            Goal.self,
            Workout.self,
            TrainingSession.self,
            WeeklyVolume.self
        ], inMemory: true)
}
