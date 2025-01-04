import SwiftUI

struct ProgramDetailsView: View {
    let program: TrainingProgram
    @State private var workouts: [WorkoutData] = []
    
    var body: some View {
        List {
            Section(header: Text("Program Details")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(program.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(program.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Label("\(program.duration) weeks", systemImage: "calendar")
                        Spacer()
                        Label("\(program.workoutsPerWeek)x/week", systemImage: "figure.run")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Upcoming Workouts")) {
                if workouts.isEmpty {
                    Text("No workouts scheduled")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(workouts) { workout in
                        WorkoutRow(workout: workout)
                    }
                }
            }
        }
        .navigationTitle("Program Details")
        .onAppear {
            // Load workouts for this program
            loadWorkouts()
        }
    }
    
    private func loadWorkouts() {
        // TODO: Implement workout loading logic
        // This would typically fetch workouts from your data store
        workouts = []
    }
}

// MARK: - Preview
struct ProgramDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProgramDetailsView(program: .sampleProgram)
        }
    }
}

// MARK: - Sample Data
extension TrainingProgram {
    static let sampleProgram = TrainingProgram(
        id: UUID().uuidString,
        name: "5K Training Plan",
        description: "A 12-week program designed to help you run your first 5K or improve your current time.",
        duration: 12,
        workoutsPerWeek: 3,
        difficulty: "Beginner",
        type: "Running"
    )
} 