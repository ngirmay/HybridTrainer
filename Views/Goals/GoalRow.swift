struct GoalRow: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: goal.type.icon)
                    .foregroundStyle(goal.type.displayColor)
                Text(goal.name)
                    .font(.headline)
                Spacer()
                if goal.completed {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
            
            HStack {
                Label(String(format: "%.1f/%.1f km", goal.currentValue, goal.targetValue),
                      systemImage: "ruler")
                Spacer()
                Text("Due \(goal.targetDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
            }
            .foregroundStyle(.secondary)
            
            if let notes = goal.notes {
                Text(notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            ProgressView(value: goal.progress)
                .tint(goal.type.displayColor)
        }
        .padding(.vertical, 4)
    }
} 