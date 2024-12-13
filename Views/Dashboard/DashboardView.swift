//
//  DashboardView.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData
import Charts

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var weeklyVolumes: [WeeklyVolume]
    @Query private var workouts: [Workout]
    
    init() {
        let weeklySort = SortDescriptor<WeeklyVolume>(\.week, order: .reverse)
        _weeklyVolumes = Query(sort: [weeklySort])
        let workoutSort = SortDescriptor<Workout>(\.date, order: .reverse)
        _workouts = Query(sort: [workoutSort])
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    WeeklyVolumeSection(weeklyVolumes: weeklyVolumes)
                        .padding(.horizontal)
                    
                    ChartSection(title: "Training Load") {
                        if weeklyVolumes.isEmpty {
                            Text("No data available")
                                .foregroundColor(.secondary)
                        } else {
                            Chart(weeklyVolumes) { volume in
                                LineMark(
                                    x: .value("Week", volume.week),
                                    y: .value("TSS", volume.totalTSS)
                                )
                            }
                            .frame(height: 200)
                        }
                    }
                    .padding(.horizontal)
                    
                    RecentWorkoutsList(workouts: workouts)
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
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
