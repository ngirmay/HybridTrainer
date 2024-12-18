import SwiftUI
import Charts
import Models

struct WorkoutInsightsView: View {
    @Environment(\.modelContext) private var modelContext
    let workouts: [Workout]
    
    var body: some View {
        VStack(spacing: Theme.Metrics.padding) {
            // Weekly Summary Cards
            HStack {
                InsightCard(
                    title: "Run",
                    value: String(format: "%.1f km", weeklyStats.run),
                    icon: "figure.run",
                    color: Theme.Colors.run,
                    workoutType: .run,
                    workouts: workouts
                )
                
                InsightCard(
                    title: "Bike",
                    value: String(format: "%.1f km", weeklyStats.bike),
                    icon: "bicycle",
                    color: Theme.Colors.bike,
                    workoutType: .bike,
                    workouts: workouts
                )
                
                InsightCard(
                    title: "Swim",
                    value: String(format: "%.1f km", weeklyStats.swim),
                    icon: "figure.pool.swim",
                    color: Theme.Colors.swim,
                    workoutType: .swim,
                    workouts: workouts
                )
            }
            
            // Simple Weekly Distance Trend
            VStack(alignment: .leading, spacing: 8) {
                Text("Weekly Distance")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.primary)
                
                Chart {
                    ForEach(recentWeeklyTotals, id: \.week) { item in
                        BarMark(
                            x: .value("Week", item.week, unit: .weekOfYear),
                            y: .value("Distance", item.distance)
                        )
                        .foregroundStyle(Theme.Colors.accent)
                    }
                }
                .frame(height: 200)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .weekOfYear)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(format: .dateTime.week())
                        }
                    }
                }
            }
            .padding()
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.Metrics.cornerRadius)
        }
        .padding()
    }
}

struct InsightCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    let workoutType: WorkoutType
    let workouts: [Workout]
    
    var body: some View {
        NavigationLink {
            ActivityDetailView(workoutType: workoutType, workouts: workouts)
        } label: {
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
        .buttonStyle(.plain)
    }
} 