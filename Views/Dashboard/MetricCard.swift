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
    
    var label: String {
        switch self {
        case .increasing: return "Up"
        case .decreasing: return "Down"
        case .neutral: return "Steady"
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
                    .foregroundStyle(iconColor)
                    .font(.title2)
                Spacer()
                TrendBadge(direction: trend)
            }
            
            if workouts.isEmpty {
                Text("No workouts yet")
                    .foregroundStyle(.secondary)
            } else {
                Text("Recent workouts: \(workouts.count)")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
        .font(.caption.monospaced())
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(direction.color.opacity(0.1))
        .foregroundStyle(direction.color)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
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
