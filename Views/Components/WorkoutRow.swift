struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            Image(systemName: workout.type.icon)
                .foregroundColor(workout.type.displayColor)
            
            VStack(alignment: .leading) {
                Text(workout.type.rawValue.capitalized)
                    .font(.headline)
                Text(workout.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if let distance = workout.distance {
                Text(String(format: "%.1f km", distance/1000))
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
} 