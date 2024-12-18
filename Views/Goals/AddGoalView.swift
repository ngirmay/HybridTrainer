import SwiftUI
import SwiftData
import Models

struct AddGoalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedType: WorkoutType = .run
    @State private var targetDistance: Double = 5000 // 5km
    @State private var targetHours: Int = 0
    @State private var targetMinutes: Int = 30
    @State private var deadline = Date().addingTimeInterval(7*24*3600) // 1 week
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Activity Type", selection: $selectedType) {
                    ForEach([WorkoutType.run, .bike, .swim], id: \.self) { type in
                        Label(type.rawValue.capitalized, 
                              systemImage: type.icon)
                            .foregroundStyle(type.displayColor)
                            .tag(type)
                    }
                }
                
                Section("Target") {
                    HStack {
                        Text("Distance (km)")
                        Spacer()
                        TextField("Distance", value: $targetDistance, 
                                format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Time")
                        Spacer()
                        HStack {
                            TextField("Hours", value: $targetHours, 
                                    format: .number)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                            Text("h")
                            TextField("Minutes", value: $targetMinutes, 
                                    format: .number)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.numberPad)
                            Text("m")
                        }
                    }
                }
                
                DatePicker("Deadline", selection: $deadline, 
                          displayedComponents: .date)
                
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
                    Button("Add") { saveGoal() }
                }
            }
        }
    }
    
    private func saveGoal() {
        let totalSeconds = Double(targetHours * 3600 + targetMinutes * 60)
        let goal = Goal(
            type: selectedType,
            targetDistance: targetDistance * 1000, // convert to meters
            targetTime: totalSeconds,
            deadline: deadline,
            notes: notes.isEmpty ? nil : notes
        )
        modelContext.insert(goal)
        dismiss()
    }
} 