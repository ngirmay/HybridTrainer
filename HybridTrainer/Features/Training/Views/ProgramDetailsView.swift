import SwiftUI

struct ProgramDetailsView: View {
    let program: TrainingProgram
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedWeek = 1
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                ProgramHeader(program: program)
                
                // Week Selector
                WeekSelector(selectedWeek: $selectedWeek, totalWeeks: 12)
                
                // Workouts List
                WorkoutsList(workouts: program.workouts)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Start Program") {
                    // Handle program start
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ProgramHeader: View {
    let program: TrainingProgram
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: program.icon)
                .font(.system(size: 40))
                .frame(width: 80, height: 80)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.top)
            
            Text(program.title)
                .font(.title.bold())
            
            Text(program.description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 24) {
                StatItem(icon: "clock", value: program.sessionDuration, unit: "min")
                StatItem(icon: "calendar", value: program.duration, unit: "")
                StatItem(icon: "chart.bar.fill", value: program.level, unit: "")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct WeekSelector: View {
    @Binding var selectedWeek: Int
    let totalWeeks: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(1...totalWeeks, id: \.self) { week in
                    Button(action: { selectedWeek = week }) {
                        Text("Week \(week)")
                            .font(.system(.subheadline, design: .rounded))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedWeek == week ? Color.black : Color.white)
                            .foregroundColor(selectedWeek == week ? .white : .black)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: selectedWeek == week ? 0 : 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct WorkoutsList: View {
    let workouts: [Workout]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(workouts) { workout in
                WorkoutCard(workout: workout)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
}

struct WorkoutCard: View {
    let workout: Workout
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: { withAnimation { isExpanded.toggle() }}) {
                HStack {
                    Text(workout.title)
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(workout.exercises) { exercise in
                        ExerciseRow(exercise: exercise)
                    }
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
} 