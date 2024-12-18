import SwiftUI
import Models

struct AddGoalView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: GoalsViewModel
    
    @State private var name = ""
    @State private var selectedType: WorkoutType = .run
    @State private var targetValue: Double = 5.0
    @State private var targetDate = Date().addingTimeInterval(7*24*3600)
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Goal Name", text: $name)
                
                Picker("Activity Type", selection: $selectedType) {
                    ForEach(WorkoutType.allCases, id: \.self) { type in
                        Label(type.rawValue.capitalized, systemImage: type.icon)
                            .foregroundStyle(type.displayColor)
                            .tag(type)
                    }
                }
                
                HStack {
                    Text("Target (km)")
                    Spacer()
                    TextField("Distance", value: $targetValue, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                DatePicker("Target Date", selection: $targetDate, displayedComponents: .date)
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("New Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { 
                        viewModel.addGoal(
                            name: name,
                            type: selectedType,
                            targetValue: targetValue,
                            targetDate: targetDate,
                            notes: notes.isEmpty ? nil : notes
                        )
                        dismiss()
                    }
                }
            }
        }
    }
} 