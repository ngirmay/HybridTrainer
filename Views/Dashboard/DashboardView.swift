//
//  DashboardView.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/10/24.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @StateObject private var viewModel = WorkoutViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    // Weekly Volume Section Placeholder
                    Text("Weekly Volume Section Temporarily Removed")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    // Placeholder for Goals Section
                    Text("Goals Section Coming Soon")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    // Placeholder for Recent Workouts Section
                    Text("Recent Workouts Section Coming Soon")
                        .font(.headline)
                        .foregroundColor(.green)
                    
                    // Placeholder for Metrics Section
                    Text("Metrics Section Coming Soon")
                        .font(.headline)
                        .foregroundColor(.purple)
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .task {
            await viewModel.loadWorkouts()
        }
    }
}




