struct GoalRow: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: goal.isRaceGoal ? "flag.filled.and.flag.crossed" : goal.type.icon)
                    .foregroundStyle(goal.type.displayColor)
                Text(goal.isRaceGoal ? "Half Ironman" : goal.type.rawValue.capitalized)
                    .font(.headline)
                Spacer()
                if goal.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
            
            if goal.isRaceGoal {
                // Show sub-goals
                if let subGoals = goal.subGoals {
                    ForEach(subGoals) { subGoal in
                        HStack {
                            Image(systemName: subGoal.type.icon)
                                .foregroundStyle(subGoal.type.displayColor)
                            Text(String(format: "%.1f km", subGoal.targetDistance/1000))
                            Text("in")
                            Text(formatDuration(subGoal.targetTime))
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }
            } else {
                // Show regular goal details
                HStack {
                    Label(String(format: "%.1f km", goal.targetDistance/1000), 
                          systemImage: "ruler")
                    Spacer()
                    Label(formatDuration(goal.targetTime), 
                          systemImage: "clock")
                }
                .foregroundStyle(.secondary)
            }
            
            if let notes = goal.notes {
                Text(notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Text("Due \(goal.deadline.formatted(date: .abbreviated, time: .omitted))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return String(format: "%d:%02d", hours, minutes)
    }
} 