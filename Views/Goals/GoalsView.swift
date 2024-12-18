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
    
    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: GoalsViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(goals) { goal in
                    Components.GoalRow(goal: goal)
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
                Components.AddGoalView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Goal.self, configurations: config)
    let context = ModelContext(container)
    
    return GoalsView(modelContext: context)
        .modelContainer(container)
}
