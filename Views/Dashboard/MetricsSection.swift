//
//  MetricsSection.swift
//  HybridTrainer
//

import SwiftUI

struct MetricsSection: View {
    let workouts: [Workout]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(WorkoutType.allCases, id: \.self) { type in
                MetricCard(
                    icon: type.icon,
                    iconColor: Color.accentColor,
                    trend: calculateTrend(for: type),
                    workouts: workouts.filter { $0.type == type }
                )
            }
        }
    }
    
    private func calculateTrend(for type: WorkoutType) -> TrendDirection {
        // You can implement your trend calculation logic here
        // For now, returning a default value
        return .neutral
    }
}

#Preview {
    MetricsSection(workouts: [])
        .padding()
}

