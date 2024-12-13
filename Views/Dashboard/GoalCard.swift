//
//  GoalCard.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI

struct GoalCard: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "figure.run")
                    .font(.title2)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(goal.name)
                        .font(.headline)
                    Text(goal.targetDate, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            ProgressView(value: 0.45)
                .tint(.blue)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
