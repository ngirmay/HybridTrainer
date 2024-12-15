import SwiftUI
import Charts
import Models

struct WorkoutInsightsView: View {
    let workouts: [Workout]
    
    private var weeklyStats: (run: Double, bike: Double, swim: Double) {
        let calendar = Calendar.current
        let weekStart = calendar.startOfWeek(for: Date())
        let weekWorkouts = workouts.filter { workout in
            calendar.isDate(workout.startDate, equalTo: weekStart, toGranularity: .weekOfYear)
        }
        
        let runDistance = weekWorkouts
            .filter { $0.type == .run }
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
        
        let bikeDistance = weekWorkouts
            .filter { $0.type == .bike }
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
        
        let swimDistance = weekWorkouts
            .filter { $0.type == .swim }
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
        
        return (run: runDistance, bike: bikeDistance, swim: swimDistance)
    }
    
    var body: some View {
        VStack(spacing: Theme.Metrics.padding) {
            // Weekly Summary Cards
            HStack {
                InsightCard(
                    title: "Run",
                    value: String(format: "%.1f km", weeklyStats.run),
                    icon: "figure.run",
                    color: Theme.Colors.run
                )
                
                InsightCard(
                    title: "Bike",
                    value: String(format: "%.1f km", weeklyStats.bike),
                    icon: "bicycle",
                    color: Theme.Colors.bike
                )
                
                InsightCard(
                    title: "Swim",
                    value: String(format: "%.1f km", weeklyStats.swim),
                    icon: "figure.pool.swim",
                    color: Theme.Colors.swim
                )
            }
        }
        .padding()
    }
}

struct InsightCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)
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