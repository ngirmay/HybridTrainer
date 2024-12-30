import SwiftUI

struct AnalyticsView: View {
    let weeklyStats = sampleWeeklyStats
    
    var body: some View {
        NavigationView {
            List {
                Section("This Week") {
                    HStack(spacing: 24) {
                        StatItem(value: weeklyStats.run.value, unit: weeklyStats.run.unit, label: weeklyStats.run.label)
                        StatItem(value: weeklyStats.bike.value, unit: weeklyStats.bike.unit, label: weeklyStats.bike.label)
                        StatItem(value: weeklyStats.swim.value, unit: weeklyStats.swim.unit, label: weeklyStats.swim.label)
                    }
                    .padding(.vertical, 8)
                }
                
                Section("Monthly Goals") {
                    GoalRow(activity: "Running", current: 85, goal: 100, unit: "mi")
                    GoalRow(activity: "Cycling", current: 320, goal: 400, unit: "mi")
                    GoalRow(activity: "Swimming", current: 12, goal: 20, unit: "mi")
                }
            }
            .navigationTitle("Analytics")
        }
    }
}

struct GoalRow: View {
    let activity: String
    let current: Double
    let goal: Double
    let unit: String
    
    var progress: Double {
        min(current / goal, 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(activity)
                Spacer()
                Text("\(Int(current))/\(Int(goal)) \(unit)")
                    .foregroundColor(.gray)
            }
            
            ProgressView(value: progress)
        }
    }
}

#Preview {
    AnalyticsView()
} 
