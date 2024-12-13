//
//  ContentView.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/12/24.
//
// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardWrapper()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            WorkoutWrapper()
                .tabItem {
                    Label("Train", systemImage: "figure.run")
                }
            
            GoalWrapper()
                .tabItem {
                    Label("Goals", systemImage: "target")
                }
        }
    }
}

// Wrappers for each section to simplify type inference
private struct DashboardWrapper: View {
    var body: some View {
        NavigationStack {
            DashboardView()
        }
    }
}

private struct WorkoutWrapper: View {
    var body: some View {
        NavigationStack {
            WorkoutViews()
        }
    }
}

private struct GoalWrapper: View {
    var body: some View {
        NavigationStack {
            GoalsView()
        }
    }
}

#Preview {
    ContentView()
}

