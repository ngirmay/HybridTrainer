//
//  MetricCard.swift
//  HybridTrainer
//
// Expected parameters: icon: iconColor: trend: workouts:
import SwiftUI
import Models

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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.title2)
                Spacer()
                TrendBadge(direction: trend)
            }
            
            if workouts.isEmpty {
                Text("No workouts yet")
                    .foregroundColor(.secondary)
            } else {
                Text("Recent workouts: \(workouts.count)")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
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

struct MetricCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MetricCard(
                icon: "figure.run",
                iconColor: .orange,
                trend: .increasing,
                workouts: []
            )
            
            MetricCard(
                icon: "figure.pool.swim",
                iconColor: .blue,
                trend: .decreasing,
                workouts: []
            )
            
            MetricCard(
                icon: "bicycle",
                iconColor: .green,
                trend: .neutral,
                workouts: []
            )
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
