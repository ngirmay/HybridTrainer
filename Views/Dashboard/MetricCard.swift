//
//  MetricCard.swift
//  HybridTrainer
//
// Expected parameters: icon: iconColor: trend: workouts:
import SwiftUI

enum TrendDirection {
    case increasing
    case decreasing
    case neutral
    
    var icon: String {
        switch self {
        case .increasing: return "arrow.up"
        case .decreasing: return "arrow.down"
        case .neutral: return "arrow.forward"
        }
    }
    
    var color: Color {
        switch self {
        case .increasing: return .green
        case .decreasing: return .red
        case .neutral: return .gray
        }
    }
}

struct MetricCard: View {
    let icon: String
    let iconColor: Color
    let trend: TrendDirection
    let workouts: [Workout]
    
    var totalDuration: TimeInterval {
        workouts.reduce(0) { $0 + $1.duration }
    }
    
    var averageHeartRate: Double? {
        let validWorkouts = workouts.compactMap { $0.averageHeartRate }
        guard !validWorkouts.isEmpty else { return nil }
        return validWorkouts.reduce(0, +) / Double(validWorkouts.count)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(iconColor)
                    .frame(width: 44, height: 44)
                    .background(iconColor.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                
                TrendBadge(direction: trend)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(formatDuration(totalDuration))
                    .font(.system(.title3, design: .serif))
                    .fontWeight(.medium)
                    .foregroundColor(Theme.textColor)
                
                if let avgHR = averageHeartRate {
                    Text("\(Int(avgHR)) BPM")
                        .font(.system(.subheadline, design: .serif))
                        .foregroundColor(Theme.secondaryText)
                }
            }
        }
        .padding(Theme.padding)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadius)
        .shadow(color: Theme.shadowColor,
                radius: Theme.shadowRadius,
                x: 0,
                y: Theme.shadowY)
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

struct TrendBadge: View {
    let direction: TrendDirection
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: direction.icon)
            Text(direction.label)
        }
        .font(.system(.caption, design: .serif))
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(direction.color.opacity(0.1))
        .foregroundColor(direction.color)
        .cornerRadius(8)
    }
}

#Preview {
    MetricCard(
        icon: "figure.run",
        iconColor: .orange,
        trend: .increasing,
        workouts: []
    )
    .padding()
    .background(Color(.systemGray6))
}
