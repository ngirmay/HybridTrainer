//
//  MetricCard.swift
//  HybridTrainer
//
// Expected parameters: icon: iconColor: trend: workouts:
import SwiftUI

struct MetricCard: View {
    let icon: String
    let iconColor: Color
    let trend: Trend
    let workouts: [Workout]
    
    enum Trend {
        case up, down, neutral
        
        var icon: String {
            switch self {
            case .up: return "arrow.up"
            case .down: return "arrow.down"
            case .neutral: return "arrow.forward"
            }
        }
        
        var color: Color {
            switch self {
            case .up: return .green
            case .down: return .red
            case .neutral: return .gray
            }
        }
    }
    
    var totalDuration: TimeInterval {
        workouts.reduce(0) { $0 + $1.duration }
    }
    
    var averageHeartRate: Double? {
        let validWorkouts = workouts.compactMap { $0.averageHeartRate }
        guard !validWorkouts.isEmpty else { return nil }
        return validWorkouts.reduce(0, +) / Double(validWorkouts.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.title2)
                
                Spacer()
                
                Image(systemName: trend.icon)
                    .foregroundColor(trend.color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(formatDuration(totalDuration))
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let avgHR = averageHeartRate {
                    Text("\(Int(avgHR)) bpm avg")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration / 3600)
        let minutes = Int((duration.truncatingRemainder(dividingBy: 3600)) / 60)
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }
}

#Preview {
    MetricCard(
        icon: "figure.run",
        iconColor: .orange,
        trend: .up,
        workouts: []
    )
    .padding()
    .background(Color(.systemGray6))
}
