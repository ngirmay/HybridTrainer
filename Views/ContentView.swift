//
//  ContentView.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData
import Models

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
            
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "figure.run")
                }
            
            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "calendar")
                }
            
            GoalsView(modelContext: modelContext)
                .tabItem {
                    Label("Goals", systemImage: "flag.fill")
                }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: [Goal.self, Workout.self, TrainingSession.self, WeeklyVolume.self],
        configurations: config
    )
    
    ContentView()
        .modelContainer(container)
} 