//
//  MetricsSection.swift
//  HybridTrainer
//

import SwiftUI

struct MetricsSection: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var selectedSport: WorkoutType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Key Metrics")
                .font(.headline)
            
            HStack {
                if selectedSport == .run {
                    if let pace = viewModel.averagePace(for: .run) {
                        MetricCard(icon: "figure.run", iconColor: .accentColor, title: "Avg Pace",
                                   value: String(format: "%.1f min/km", pace))
                    } else {
                        MetricCard(icon: "figure.run", iconColor: .accentColor, title: "Avg Pace", value: "N/A")
                    }
                } else if selectedSport == .swim {
                    MetricCard(icon: "figure.pool.swim", iconColor: .accentColor, title: "Stroke Count", value: "N/A")
                } else if selectedSport == .bike {
                    MetricCard(icon: "figure.outdoor.cycle", iconColor: .accentColor, title: "Cadence", value: "N/A")
                } else {
                    let count = viewModel.workouts(for: nil).count
                    MetricCard(icon: "list.bullet", iconColor: .accentColor, title: "Total Workouts", value: "\(count)")
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

