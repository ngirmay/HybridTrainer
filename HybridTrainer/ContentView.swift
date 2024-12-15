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
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Workout.self, Goal.self, TrainingSession.self])
}


