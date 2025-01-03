import SwiftUI
import Models.Training

// Sample data for preview
private let samplePrograms = [
    TrainingProgram(
        title: "5K Training",
        description: "8-week program to prepare for a 5K race",
        duration: "8 weeks",
        icon: "figure.run"
    ),
    TrainingProgram(
        title: "Strength Basics",
        description: "Foundation strength training program",
        duration: "12 weeks",
        icon: "dumbbell.fill"
    )
]

struct TrainingProgramsView: View {
    @State private var showingCreateProgram = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(samplePrograms) { program in
                        NavigationLink(destination: ProgramDetailsView(program: program)) {
                            ProgramRow(program: program)
                        }
                    }
                }
            }
            .navigationTitle("Training")
            .toolbar {
                Button(action: { showingCreateProgram = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingCreateProgram) {
                CreateProgramView()
            }
        }
    }
}

struct ProgramRow: View {
    let program: TrainingProgram
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: program.icon)
                .font(.system(size: 24))
                .frame(width: 40, height: 40)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(program.title)
                    .font(.headline)
                Text(program.duration)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TrainingProgramsView()
} 