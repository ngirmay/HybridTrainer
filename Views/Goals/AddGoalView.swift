import SwiftUI
import Models

struct AddGoalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var type: WorkoutType = .run
    @State private var targetValue: Double = 0
    @State private var targetDate = Date()
    @State private var notes = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Goal Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(WorkoutType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.icon)
                            .tag(type)
                    }
                }
                
                HStack {
                    Text("Target")
                    Spacer()
                    TextField("Value", value: $targetValue, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                
                DatePicker("Target Date", selection: $targetDate, displayedComponents: .date)
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addGoal()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    private func addGoal() {
        let goal = Goal(
            name: name,
            targetDate: targetDate,
            type: type,
            targetValue: targetValue,
            notes: notes.isEmpty ? nil : notes
        )
        modelContext.insert(goal)
        dismiss()
    }
}

#Preview {
    AddGoalView()
}