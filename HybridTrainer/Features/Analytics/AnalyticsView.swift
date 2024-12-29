import SwiftUI

struct AnalyticsView: View {
    let weeklyStats = sampleWeeklyStats
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Weekly Summary
                    VStack(alignment: .leading, spacing: 16) {
                        Text("This Week")
                            .font(.title)
                        
                        HStack(spacing: 24) {
                            StatItem(value: weeklyStats.run.value, unit: weeklyStats.run.unit, label: weeklyStats.run.label)
                            StatItem(value: weeklyStats.bike.value, unit: weeklyStats.bike.unit, label: weeklyStats.bike.label)
                            StatItem(value: weeklyStats.swim.value, unit: weeklyStats.swim.unit, label: weeklyStats.swim.label)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }
                .padding()
            }
            .navigationTitle("Analytics")
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct GoalProgressRow: View {
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
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * progress, height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    AnalyticsView()
} 
