import SwiftUI
import Charts
import Models

struct WorkoutInsightsView: View {
    @Environment(\.modelContext) private var modelContext
    let workouts: [Workout]
    private let workoutService: WorkoutDataService
    
    init(workouts: [Workout]) {
        self.workouts = workouts
        self.workoutService = WorkoutDataService(modelContext: modelContext)
    }
    
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
    
    // Simplified to just show last 4 weeks total distance
    private var recentWeeklyTotals: [(week: Date, distance: Double)] {
        let calendar = Calendar.current
        let now = Date()
        let fourWeeksAgo = calendar.date(byAdding: .weekOfYear, value: -3, to: now)!
        
        return workouts
            .filter { $0.startDate >= fourWeeksAgo }
            .compactMap { workout -> (Date, Double)? in
                guard let distance = workout.distance else { return nil }
                let weekStart = calendar.startOfWeek(for: workout.startDate)
                return (weekStart, distance / 1000)
            }
            .reduce(into: [:]) { result, item in
                result[item.0, default: 0] += item.1
            }
            .map { ($0.key, $0.value) }
            .sorted { $0.0 < $1.0 }
    }
    
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