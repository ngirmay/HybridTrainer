import SwiftUI
import Charts
import Models

struct WorkoutInsightsView: View {
    let workouts: [Workout]
    
    private var totalDistance: Double {
        workouts.compactMap { $0.distance }.reduce(0, +) / 1000 // Convert to km
    }
    
    private var totalDuration: TimeInterval {
        workouts.map { $0.duration }.reduce(0, +)
    }
    
    private var weeklyTrend: [(week: Date, distance: Double)] {
        // Group workouts by week and calculate total distance
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: workouts) { workout in
            calendar.startOfWeek(for: workout.startDate)
        }
        
        return grouped.map { (week, workouts) in
            (
                week: week,
                distance: workouts.compactMap { $0.distance }.reduce(0, +) / 1000
            )
        }.sorted { $0.week < $1.week }
    }
    
    var body: some View {
        VStack(spacing: Theme.Metrics.padding) {
            // Summary Cards
            HStack {
                InsightCard(
                    title: "Total Distance",
                    value: String(format: "%.1f km", totalDistance),
                    icon: "figure.run"
                )
                
                InsightCard(
                    title: "Total Time",
                    value: formatDuration(totalDuration),
                    icon: "clock"
                )
            }
            
            // Weekly Distance Trend
            VStack(alignment: .leading) {
                Text("Weekly Distance")
                    .font(.headline)
                    .foregroundStyle(Theme.Colors.primary)
                
                Chart(weeklyTrend, id: \.week) { item in
                    LineMark(
                        x: .value("Week", item.week, unit: .weekOfYear),
                        y: .value("Distance", item.distance)
                    )
                    .foregroundStyle(Theme.Colors.accent)
                    
                    AreaMark(
                        x: .value("Week", item.week, unit: .weekOfYear),
                        y: .value("Distance", item.distance)
                    )
                    .foregroundStyle(Theme.Colors.accent.opacity(0.1))
                }
                .frame(height: 200)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
            }
            .padding()
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.Metrics.cornerRadius)
        }
        .padding()
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return "\(hours)h \(minutes)m"
    }
}

struct InsightCard: View {
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