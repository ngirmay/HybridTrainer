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
    let schema = Schema([
        Goal.self,
        Workout.self,
        TrainingSession.self,
        WeeklyVolume.self
    ])
    let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: schema, configurations: config)
    
    ContentView()
        .modelContainer(container)
} 