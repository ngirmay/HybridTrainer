import SwiftUI

struct CreateProgramView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var programTitle = ""
    @State private var programCategory: ProgramCategory = .custom
    @State private var duration = ""
    @State private var description = ""
    @State private var sessionDuration = ""
    @State private var level = ""
    @State private var icon = "figure.run"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Program Details")) {
                    TextField("Program Title", text: $programTitle)
                    
                    Picker("Category", selection: $programCategory) {
                        ForEach(ProgramCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    
                    TextField("Duration", text: $duration)
                        .placeholder("e.g., 8-week program")
                    
                    TextField("Session Duration", text: $sessionDuration)
                        .placeholder("e.g., 45-60 minutes")
                    
                    TextField("Level", text: $level)
                        .placeholder("e.g., Intermediate")
                    
                    TextField("Description", text: $description)
                        .placeholder("Program description")
                }
            }
            .navigationTitle("Create Program")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let program = TrainingProgram(
                        icon: icon,
                        title: programTitle,
                        category: programCategory,
                        duration: duration,
                        description: description,
                        sessionDuration: sessionDuration,
                        level: level
                    )
                    // TODO: Save program
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

extension View {
    func placeholder(_ text: String) -> some View {
        self.placeholder(when: self is TextField<Text>, placeholder: {
            Text(text).foregroundColor(.gray)
        })
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    CreateProgramView()
} 