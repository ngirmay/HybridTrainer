//
//  GoalCard.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI
import Models

public struct GoalCard: View {
    let goal: Goal
    
    public init(goal: Goal) {
        self.goal = goal
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: goal.type.icon)
                    .foregroundStyle(goal.completed ? .green : goal.type.color)
                    .font(.title2)
                Spacer()
                if goal.completed {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
            
            Text(goal.name)
                .font(.headline)
            
            Text(String(format: "%.1f/%.1f km", goal.currentValue, goal.targetValue))
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            ProgressView(value: goal.progress)
                .tint(goal.type.color)
            
            Text(goal.targetDate.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    GoalCard(goal: Goal(
        name: "Run 10K",
        targetDate: Date().addingTimeInterval(7*24*3600),
        type: .run,
        targetValue: 10.0 // 10 km
    ))
    .padding()
    .background(Color(.systemGray6))
}
