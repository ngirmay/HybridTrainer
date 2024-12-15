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

public struct GoalsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Goal.targetDate) private var goals: [Goal]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            Group {
                if goals.isEmpty {
                    ContentUnavailableView {
                        Label("No Goals", systemImage: "target")
                    } description: {
                        Text("Set training goals to track your progress")
                    } actions: {
                        Button(action: addSampleGoal) {
                            Text("Add Goal")
                        }
                    }
                } else {
                    List {
                        ForEach(goals) { goal in
                            GoalCard(goal: goal)
                                .listRowBackground(Theme.Colors.cardBackground)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Theme.Colors.background)
                }
            }
            .navigationTitle("Goals")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addSampleGoal) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteGoals(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(goals[index])
        }
    }
    
    private func addSampleGoal() {
        let goal = Goal(
            name: "Complete Half Marathon",
            targetDate: Date().addingTimeInterval(60*60*24*90), // 90 days from now
            type: .run,
            targetValue: 21.1 // 21.1 km
        )
        modelContext.insert(goal)
    }
}

struct GoalRow: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(goal.name)
                .font(.headline)
            
            HStack {
                Image(systemName: goal.type.icon)
                    .foregroundStyle(goal.type.displayColor)
                Text(goal.targetDate.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(format: "%.1f/%.1f km", goal.currentValue, goal.targetValue))
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
