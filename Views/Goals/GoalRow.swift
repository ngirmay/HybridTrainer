import SwiftUI
import Models

struct GoalRow: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: goal.type.icon)
                    .foregroundStyle(goal.type.displayColor)
                Text(goal.name)
                    .font(.headline)
            }
            
            if let notes = goal.notes {
                Text(notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                Text("\(goal.targetValue, specifier: "%.1f")")
                Spacer()
                Text(goal.targetDate.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.secondary)
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
        .padding(.vertical, 4)
    }
}

#Preview {
    GoalRow(goal: Goal(
        name: "Complete Half Ironman",
        targetDate: Date().addingTimeInterval(90*24*3600),
        type: .triathlon,
        targetValue: 5.5,
        notes: "Finish under 5:30:00"
    ))
    .padding()
}