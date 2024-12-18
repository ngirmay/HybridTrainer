//
//  GoalCard.swift
//  HybridTrainer
//

import SwiftUI
import Models

struct GoalCard: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(goal.name)
                .font(.headline)
            
            if let notes = goal.notes {
                Text(notes)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label("\(goal.targetValue, specifier: "%.1f")", 
                      systemImage: goal.type.icon)
                    .foregroundStyle(goal.type.displayColor)
                
                Spacer()
                
                Text(goal.targetDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.2))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(goal.type.displayColor)
                        .frame(width: geometry.size.width * goal.progress, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding()
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.Metrics.cornerRadius)
    }
}

#Preview {
    // Create a Half Ironman goal for preview
    let halfIronmanDate = Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25))!
    let goal = Goal(
        name: "Complete Half Ironman",
        targetDate: halfIronmanDate,
        type: .triathlon,
        targetValue: 5.5,
        notes: "Finish the Half Ironman triathlon in under 5:30:00. Includes: 1.2mi swim, 56mi bike, 13.1mi run"
    )
    
    GoalCard(goal: goal)
        .padding()
        .background(Theme.Colors.background)
}