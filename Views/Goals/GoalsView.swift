//
//  GoalsView.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

// Views/Goals/GoalsView.swift
import SwiftUI
import SwiftData
import Models

struct GoalsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Goal.deadline) private var goals: [Goal]
    @State private var showingAddGoal = false
    
    var body: some View {
        NavigationStack {
            List {
                if goals.isEmpty {
                    ContentUnavailableView {
                        Label("No Goals", systemImage: "flag.filled.and.flag.crossed")
                    } description: {
                        Text("Set training goals to track your progress")
                    } actions: {
                        Button(action: addHalfIronmanGoal) {
                            Text("Add Half Ironman Goal")
                        }
                    }
                }
                
                ForEach(goals) { goal in
                    GoalRow(goal: goal)
                }
                .onDelete(perform: deleteGoals)
            }
            .navigationTitle("Training Goals")
            .toolbar {
                Menu {
                    Button(action: { showingAddGoal = true }) {
                        Label("Add Custom Goal", systemImage: "plus")
                    }
                    Button(action: addHalfIronmanGoal) {
                        Label("Add Half Ironman Goal", systemImage: "flag.filled.and.flag.crossed")
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView()
            }
        }
    }
    
    private func deleteGoals(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(goals[index])
        }
    }
    
    private func addHalfIronmanGoal() {
        // June 15th, 2025
        let raceDate = Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 15))!
        let goal = Goal.halfIronman(deadline: raceDate)
        modelContext.insert(goal)
    }
}

struct GoalRow: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: goal.type.icon)
                    .foregroundStyle(goal.type.displayColor)
                Text(goal.type.rawValue.capitalized)
                    .font(.headline)
                Spacer()
                if goal.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }
            
            HStack {
                Label(String(format: "%.1f km", goal.targetDistance/1000), 
                      systemImage: "ruler")
                Spacer()
                Label(formatDuration(goal.targetTime), 
                      systemImage: "clock")
            }
            .foregroundStyle(.secondary)
            
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

#Preview {
    GoalsView()
        .modelContainer(for: [Goal.self], inMemory: true)
}
