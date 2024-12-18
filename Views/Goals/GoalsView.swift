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
    @StateObject private var viewModel: GoalsViewModel
    @State private var showingAddGoal = false
    
    init() {
        _viewModel = StateObject(wrappedValue: GoalsViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(goals) { goal in
                    GoalRow(goal: goal)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteGoal(goals[index])
                    }
                }
            }
            .navigationTitle("Training Goals")
            .toolbar {
                Menu {
                    Button(action: { showingAddGoal = true }) {
                        Label("Add Custom Goal", systemImage: "plus")
                    }
                    Button(action: viewModel.addHalfIronmanGoals) {
                        Label("Add Half Ironman Goals", systemImage: "flag.filled.and.flag.crossed")
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    GoalsView()
        .modelContainer(for: [Goal.self], inMemory: true)
}
