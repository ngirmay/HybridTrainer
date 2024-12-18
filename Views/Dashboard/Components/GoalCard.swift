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
            Text(goal.title)
                .font(.headline)
            
            if let description = goal.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label("\(goal.targetValue, specifier: "%.1f") \(goal.unit)", 
                      systemImage: "target")
                
                Spacer()
                
                Text(goal.targetDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    // Create a Half Ironman goal for preview
    let halfIronmanDate = Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 25))!
    let goal = Goal(
        title: "Complete Half Ironman",
        description: "Finish the Half Ironman triathlon in under 5:30:00. Includes: 1.2mi swim, 56mi bike, 13.1mi run",
        targetValue: 5.5,
        unit: "hours",
        targetDate: halfIronmanDate
    )
    
    return GoalCard(goal: goal)
        .previewLayout(.sizeThatFits)
        .padding()
}