struct WorkoutInsightsView: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Use formatted date instead of raw date
            Text(workout.startDate.formatted(date: .abbreviated, time: .shortened))
                .font(.headline)
            
            if let distance = workout.distance {
                Text(String(format: "Distance: %.1f km", distance / 1000))
            }
            
            if let calories = workout.calories {
                Text(String(format: "Calories: %.0f kcal", calories))
            }
            
            Text(String(format: "Duration: %.0f min", workout.duration / 60))
        }
        .padding()
    }
}

#Preview {
    WorkoutInsightsView(workout: Workout(
        type: .run,
        startDate: Date(),
        duration: 1800,
        distance: 5000,
        calories: 400
    ))
} 