//
//  ContentView.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/12/24.
//

import SwiftUI
import SwiftData
import Models

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var workoutViewModel: WorkoutViewModel
    
    init() {
        let container = DependencyContainer.shared
        _workoutViewModel = StateObject(wrappedValue: WorkoutViewModel(workoutService: container.workoutService))
    }
    
    var body: some View {
        TabView {
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "figure.run")
                }
            
            GoalsView()
                .tabItem {
                    Label("Goals", systemImage: "target")
                }
            
            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "calendar")
                }
        }
        .task {
            // Load data when app launches
            await workoutViewModel.loadWorkouts()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Workout.self, Goal.self, TrainingSession.self])
}


