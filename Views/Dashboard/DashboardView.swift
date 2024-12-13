//
//  DashboardView.swift
//  HybridTrainer
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    @State private var selectedSport: WorkoutType? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    SportPickerView(selectedSport: $selectedSport)
                    
                    WeeklyVolumeSection(viewModel: viewModel, selectedSport: selectedSport)
                    
                    TrainingDistributionSection(viewModel: viewModel, selectedSport: selectedSport)
                    
                    MetricsSection(viewModel: viewModel, selectedSport: selectedSport)
                    
                    RecentWorkoutsSection(viewModel: viewModel, selectedSport: selectedSport)
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
