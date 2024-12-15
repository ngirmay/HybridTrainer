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
    
    private var weeklyTrends: [(week: Date, type: WorkoutType, distance: Double)] {
        let calendar = Calendar.current
        let now = Date()
        let fourWeeksAgo = calendar.date(byAdding: .weekOfYear, value: -3, to: now)!
        
        return workouts
            .filter { $0.startDate >= fourWeeksAgo }
            .compactMap { workout -> (Date, WorkoutType, Double)? in
                guard let distance = workout.distance else { return nil }
                let weekStart = calendar.startOfWeek(for: workout.startDate)
                return (weekStart, workout.type, distance / 1000)
            }
            .reduce(into: [(Date, WorkoutType, Double)]()) { result, item in
                if let index = result.firstIndex(where: { $0.0 == item.0 && $0.1 == item.1 }) {
                    result[index].2 += item.2
                } else {
                    result.append(item)
                }
            }
            .sorted { $0.week < $1.week }
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
            VStack(alignment: .leading, spacing: 8) {
                Text("Weekly Distance")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.primary)
                
                Chart {
                    ForEach(weeklyTrends, id: \.week) { item in
                        BarMark(
                            x: .value("Week", item.week, unit: .weekOfYear),
                            y: .value("Distance", item.distance)
                        )
                        .foregroundStyle(by: .value("Activity", item.type))
                    }
                }
                .frame(height: 200)
                .chartForegroundStyleScale([
                    WorkoutType.run: Theme.Colors.run,
                    WorkoutType.bike: Theme.Colors.bike,
                    WorkoutType.swim: Theme.Colors.swim
                ])
                .chartXAxis {
                    AxisMarks(values: .stride(by: .weekOfYear)) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(format: .dateTime.week())
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartLegend(position: .bottom)
            }
            .padding()
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.Metrics.cornerRadius)
            
            // Activity Distribution
            VStack(alignment: .leading, spacing: 8) {
                Text("Activity Distribution")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.primary)
                
                Chart {
                    ForEach(weeklyTrends, id: \.week) { item in
                        SectorMark(
                            angle: .value("Distance", item.distance)
                        )
                        .foregroundStyle(by: .value("Activity", item.type))
                    }
                }
                .frame(height: 150)
                .chartForegroundStyleScale([
                    WorkoutType.run: Theme.Colors.run,
                    WorkoutType.bike: Theme.Colors.bike,
                    WorkoutType.swim: Theme.Colors.swim
                ])
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