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
    @Query private var workouts: [Workout]
    @Query private var goals: [Goal]
    @Query private var trainingSessions: [TrainingSession]
    
    var body: some View {
        TabView {
            NavigationStack {
                List {
                    ForEach(workouts) { workout in
                        WorkoutRow(workout: workout)
                    }
                }
                .navigationTitle("Workouts")
            }
            .tabItem {
                Label("Workouts", systemImage: "figure.run")
            }
            
            NavigationStack {
                List {
                    ForEach(goals) { goal in
                        Text(goal.name)
                    }
                }
                .navigationTitle("Goals")
            }
            .tabItem {
                Label("Goals", systemImage: "target")
            }
            
            NavigationStack {
                List {
                    ForEach(trainingSessions) { session in
                        Text(session.date.formatted(date: .abbreviated, time: .shortened))
                    }
                }
                .navigationTitle("Training")
            }
            .tabItem {
                Label("Training", systemImage: "calendar")
            }
        }
    }
}

#Preview {
    ContentView()
}


