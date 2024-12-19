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
    @StateObject private var viewModel: GoalsViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: GoalsViewModel(modelContext: modelContext))
    }
    
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
                AddGoalView(viewModel: viewModel)
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
    let container = try! ModelContainer(for: Goal.self, configurations: config)
    
    return GoalsView()
        .modelContainer(container)
}
