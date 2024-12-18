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
    @Query(sort: \Goal.targetDate) private var goals: [Goal]
    @State private var showingAddGoal = false
    
    var body: some View {
        NavigationStack {
            List {
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
                    Button(action: addHalfIronmanGoals) {
                        Label("Add Half Ironman Goals", systemImage: "flag.filled.and.flag.crossed")
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
    
    private func addHalfIronmanGoals() {
        // June 15th, 2025
        let raceDate = Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 15))!
        let goals = Goal.halfIronman(targetDate: raceDate)
        goals.forEach { modelContext.insert($0) }
    }
}

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

#Preview {
    GoalsView()
        .modelContainer(for: [Goal.self], inMemory: true)
}
