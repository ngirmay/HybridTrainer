import SwiftUI
import Charts
import Models

struct ActivityDetailView: View {
    let workoutType: WorkoutType
    let workouts: [Workout]
    
    private var filteredWorkouts: [Workout] {
        workouts.filter { $0.type == workoutType }
            .sorted { $0.startDate > $1.startDate }
    }
    
    private var totalDistance: Double {
        filteredWorkouts
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
    }
    
    private var averagePace: TimeInterval? {
        guard !filteredWorkouts.isEmpty else { return nil }
        let totalTime = filteredWorkouts.map { $0.duration }.reduce(0, +)
        let totalDist = filteredWorkouts.compactMap { $0.distance }.reduce(0, +)
        guard totalDist > 0 else { return nil }
        return (totalTime / 60) / (totalDist / 1000) // minutes per km
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Theme.Metrics.padding) {
                // Summary Stats
                HStack {
                    StatCard(
                        title: "Total Distance",
                        value: String(format: "%.1f km", totalDistance),
                        icon: "ruler"
                    )
                    
                    if let pace = averagePace {
                        StatCard(
                            title: "Average Pace",
                            value: String(format: "%.1f min/km", pace),
                            icon: "speedometer"
                        )
                    }
                }
                
                // Recent Activities List
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recent Activities")
                        .font(.headline)
                        .foregroundStyle(Theme.Colors.primary)
                    
                    ForEach(filteredWorkouts) { workout in
                        WorkoutRow(workout: workout)
                            .padding(.vertical, 4)
                    }
                }
                .padding()
                .background(Theme.Colors.cardBackground)
                .cornerRadius(Theme.Metrics.cornerRadius)
            }
            .padding()
        }
        .background(Theme.Colors.background)
        .navigationTitle(workoutType.rawValue.capitalized)
    }
}

private struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(Theme.Colors.accent)
                Text(title)
                    .foregroundStyle(Theme.Colors.secondary)
            }
            .font(.subheadline)
            
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(Theme.Colors.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.Metrics.cornerRadius)
    }
}

#Preview {
    NavigationStack {
        ActivityDetailView(
            workoutType: .run,
            workouts: [
                Workout(type: .run, startDate: Date(), duration: 3600, distance: 10000),
                Workout(type: .run, startDate: Date().addingTimeInterval(-86400), duration: 3000, distance: 8000)
            ]
        )
    }
    .modelContainer(for: [Workout.self], inMemory: true)
} 