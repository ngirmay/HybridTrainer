import SwiftUI

struct CreateProgramView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var programName = ""
    @State private var programCategory: ProgramCategory = .custom
    @State private var duration = ""
    @State private var description = ""
    @State private var level = ""
    @State private var workouts: [Workout] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Program Details")) {
                    TextField("Program Name", text: $programName)
                    Picker("Category", selection: $programCategory) {
                        ForEach(ProgramCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    TextField("Duration (weeks)", text: $duration)
                        .keyboardType(.numberPad)
                    TextField("Description", text: $description)
                    TextField("Level", text: $level)
                }
                
                Section(header: Text("Workouts")) {
                    ForEach(workouts) { workout in
                        Text(workout.title)
                    }
                    
                    Button("Add Workout") {
                        // Show workout creation sheet
                    }
                }
            }
            .navigationTitle("Create Program")
            .navigationBarItems(
                leading: Button("Cancel") { presentationMode.wrappedValue.dismiss() },
                trailing: Button("Save") {
                    // Save program
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
} 