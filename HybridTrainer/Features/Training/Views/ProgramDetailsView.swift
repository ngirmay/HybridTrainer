import SwiftUI

struct ProgramDetailsView: View {
    let program: TrainingProgram
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    Image(systemName: program.icon)
                        .font(.system(size: 40))
                        .frame(width: 60, height: 60)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    
                    VStack(alignment: .leading) {
                        Text(program.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(program.duration)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                
                // Description
                Text(program.description)
                    .padding(.horizontal)
                
                // Workouts
                if !program.workouts.isEmpty {
                    Section(header: Text("Workouts").font(.headline).padding()) {
                        ForEach(program.workouts) { workout in
                            WorkoutRow(workout: workout)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ProgramDetailsView(program: samplePrograms[0])
    }
} 