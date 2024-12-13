//
//  RecentWorkoutsSection.swift
//  HybridTrainer
//

import SwiftUI

struct RecentWorkoutsSection: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var selectedSport: WorkoutType?

    var body: some View {
        let recent = viewModel.workouts(for: selectedSport).prefix(5)
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workouts")
                .font(.headline)
            
            if recent.isEmpty {
                Text("No recent workouts for this selection.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(Array(recent), id: \.id) { workout in
                    WorkoutRow(workout: workout)
                }
            }
        }
    }
}
