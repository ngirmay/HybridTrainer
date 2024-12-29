//
//  TrainingView.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData
import Models

public struct TrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TrainingSession.date) private var sessions: [TrainingSession]
    @StateObject private var viewModel: TrainingPlanViewModel
    @State private var selectedPlan: String? = nil
    @State private var showingPlanSelector = false
    
    public init() {
        _viewModel = StateObject(wrappedValue: TrainingPlanViewModel(
            modelContext: DependencyContainer.shared.modelContainer.mainContext))
    }
    
    public var body: some View {
        NavigationStack {
            Group {
                if let selectedPlan {
                    TrainingPlanView(planId: selectedPlan)
                } else if sessions.isEmpty {
                    ContentUnavailableView {
                        Label("No Training Plan", systemImage: "calendar")
                    } description: {
                        Text("Select a training plan to get started")
                    } actions: {
                        Button(action: { showingPlanSelector = true }) {
                            Text("Select Plan")
                        }
                    }
                } else {
                    List {
                        ForEach(sessions) { session in
                            TrainingSessionRow(session: session)
                        }
                        .onDelete(perform: deleteSessions)
                    }
                }
            }
            .navigationTitle("Training")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingPlanSelector = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingPlanSelector) {
                PlanSelectorView(selectedPlan: $selectedPlan)
            }
        }
    }
    
    private func deleteSessions(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(sessions[index])
        }
    }
}

struct TrainingSessionRow: View {
    let session: TrainingSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: session.type.icon)
                    .foregroundStyle(session.type.displayColor)
                Text(session.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.headline)
            }
            
            if let distance = session.plannedDistance {
                Text("\(Int(distance/1000)) km")
                    .foregroundStyle(.secondary)
            }
            
            if let duration = session.plannedDuration {
                Text("\(Int(duration/60)) minutes")
                    .foregroundStyle(.secondary)
            }
            
            if let notes = session.notes {
                Text(notes)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 4)
    }
}

// Plan selector view
struct PlanSelectorView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedPlan: String?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        selectedPlan = "plan_a"
                        dismiss()
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Plan A - Ironman 70.3")
                                .font(.headline)
                            Text("32 week plan with structured progression")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("Available Plans")
                } footer: {
                    Text("More plans coming soon")
                }
            }
            .navigationTitle("Select Training Plan")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

// Training plan view
struct TrainingPlanView: View {
    let planId: String
    @State private var currentPhase: TrainingPhase = .base
    @State private var currentWeek: TrainingWeek?
    
    var body: some View {
        List {
            Section("Current Phase") {
                PhaseProgressView(phase: currentPhase)
            }
            
            if let week = currentWeek {
                Section("This Week") {
                    ForEach(week.sessions) { day in
                        DayScheduleRow(day: day)
                    }
                }
                
                Section("Weekly Goals") {
                    WeeklyMetricsRow(metrics: week.metrics)
                }
            }
        }
    }
}

// Supporting Views
struct DayScheduleRow: View {
    let day: TrainingDay
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(day.date.formatted(date: .abbreviated, time: .omitted))
                .font(.headline)
            
            ForEach(day.workouts) { workout in
                HStack {
                    Image(systemName: workout.type.icon)
                        .foregroundStyle(workout.type.displayColor)
                    Text(workout.description)
                    Spacer()
                    if workout.isCompleted {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    }
                }
            }
            
            if let notes = day.notes {
                Text(notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct WeeklyMetricsRow: View {
    let metrics: WeeklyMetrics
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let run = metrics.runMileage {
                Label("\(Int(run)) miles", systemImage: "figure.run")
            }
            if let bike = metrics.bikeMileage {
                Label("\(Int(bike)) miles", systemImage: "bicycle")
            }
            if let swim = metrics.swimMileage {
                Label("\(Int(swim)) miles", systemImage: "figure.pool.swim")
            }
            Label(metrics.isClean ? "Clean Week" : "Dirty Week", 
                  systemImage: metrics.isClean ? "checkmark.circle" : "exclamationmark.circle")
        }
    }
}

#Preview {
    TrainingView()
        .modelContainer(for: [TrainingSession.self], inMemory: true)
} 