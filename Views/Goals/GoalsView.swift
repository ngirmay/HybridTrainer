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
            Group {
                if goals.isEmpty {
                    ContentUnavailableView {
                        Label("No Goals", systemImage: "flag.fill")
                    } description: {
                        Text("Add your first training goal")
                    } actions: {
                        Button(action: { showingAddGoal = true }) {
                            Text("Add Goal")
                        }
                    }
                } else {
                    List {
                        ForEach(goals) { goal in
                            GoalRow(goal: goal)
                        }
                        .onDelete(perform: deleteGoals)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Goals")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddGoal = true }) {
                        Image(systemName: "plus")
                    }
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
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let schema = Schema([Goal.self])
    let container = try! ModelContainer(for: schema, configurations: config)
    
    // Add a sample goal
    let context = container.mainContext
    let goal = Goal(
        name: "Complete Half Ironman",
        targetDate: Date().addingTimeInterval(90*24*3600),
        type: .triathlon,
        targetValue: 5.5,
        notes: "Finish under 5:30:00"
    )
    context.insert(goal)
    
    return GoalsView()
        .modelContainer(container)
}
