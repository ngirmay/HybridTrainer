//
//  ContentView.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/12/24.
//
// ContentView.swift
import SwiftUI
import SwiftData
import Models

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Workout.startDate, order: .reverse) private var workouts: [Workout]
    @Query(sort: \Goal.targetDate) private var goals: [Goal]
    @Query(sort: \TrainingSession.date, order: .reverse) private var trainingSessions: [TrainingSession]
    
    var body: some View {
        TabView {
            WorkoutsTab(workouts: workouts)
                .tabItem {
                    Label("Workouts", systemImage: "figure.run")
                }
            
            GoalsTab(goals: goals)
                .tabItem {
                    Label("Goals", systemImage: "target")
                }
            
            TrainingTab(sessions: trainingSessions)
                .tabItem {
                    Label("Training", systemImage: "calendar")
                }
        }
    }
}

private struct WorkoutsTab: View {
    let workouts: [Workout]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    WorkoutRow(workout: workout)
                }
            }
            .navigationTitle("Workouts")
        }
    }
}

private struct GoalsTab: View {
    let goals: [Goal]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(goals) { goal in
                    Text(goal.name)
                }
            }
            .navigationTitle("Goals")
        }
    }
}

private struct TrainingTab: View {
    let sessions: [TrainingSession]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sessions) { session in
                    Text(session.date.formatted(date: .abbreviated, time: .shortened))
                }
            }
            .navigationTitle("Training")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Workout.self, Goal.self, TrainingSession.self])
}


