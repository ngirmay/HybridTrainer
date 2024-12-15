import SwiftUI
import Charts
import Models

struct WorkoutInsightsView: View {
    let workouts: [Workout]
    @State private var isWorkoutListExpanded = false
    
    private var currentWeekWorkouts: [Workout] {
        let calendar = Calendar.current
        let weekStart = calendar.startOfWeek(for: Date())
        return workouts.filter { workout in
            calendar.isDate(workout.startDate, equalTo: weekStart, toGranularity: .weekOfYear)
        }
    }
    
    private var weeklyStats: (run: Double, bike: Double, swim: Double) {
        let runDistance = currentWeekWorkouts
            .filter { $0.type == .run }
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
        
        let bikeDistance = currentWeekWorkouts
            .filter { $0.type == .bike }
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
        
        let swimDistance = currentWeekWorkouts
            .filter { $0.type == .swim }
            .compactMap { $0.distance }
            .reduce(0, +) / 1000
        
        return (run: runDistance, bike: bikeDistance, swim: swimDistance)
    }
    
    private var weeklyTrendByType: [(date: Date, type: WorkoutType, distance: Double)] {
        let calendar = Calendar.current
        let sixWeeksAgo = calendar.date(byAdding: .weekOfYear, value: -5, to: calendar.startOfWeek(for: Date()))!
        
        return workouts
            .filter { $0.startDate >= sixWeeksAgo }
            .reduce(into: [(Date, WorkoutType, Double)]()) { result, workout in
                let weekStart = calendar.startOfWeek(for: workout.startDate)
                if let distance = workout.distance {
                    result.append((weekStart, workout.type, distance / 1000))
                }
            }
            .sorted { $0.date < $1.date }
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
            
            // Weekly Trend Chart
            VStack(alignment: .leading) {
                Text("Weekly Distance Trend")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.primary)
                
                Chart {
                    ForEach(weeklyTrendByType, id: \.date) { item in
                        LineMark(
                            x: .value("Week", item.date, unit: .weekOfYear),
                            y: .value("Distance", item.distance)
                        )
                        .foregroundStyle(by: .value("Activity", item.type))
                    }
                }
                .frame(height: 200)
                .chartForegroundStyleScale([
                    "Run": Theme.Colors.run,
                    "Bike": Theme.Colors.bike,
                    "Swim": Theme.Colors.swim
                ])
                .chartLegend(position: .bottom)
            }
            .padding()
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.Metrics.cornerRadius)
            
            // Collapsible Workout List
            DisclosureGroup(
                isExpanded: $isWorkoutListExpanded,
                content: {
                    ForEach(workouts) { workout in
                        WorkoutRow(workout: workout)
                            .padding(.vertical, 4)
                    }
                },
                label: {
                    Text("Recent Workouts")
                        .font(.headline)
                        .foregroundStyle(Theme.Colors.primary)
                }
            )
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