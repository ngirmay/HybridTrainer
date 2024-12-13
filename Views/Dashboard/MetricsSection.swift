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
                    iconColor: Color(type.iconColor),
                    trend: .up,  // You can calculate this based on your data
                    workouts: workouts.filter { $0.type == type }
                )
            }
        }
    }
}

struct MetricCard: View {
    let icon: String
    let iconColor: Color
    let trend: Trend
    let workouts: [Workout]
    
    enum Trend {
        case up, down, neutral
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
            
            // Rest of your MetricCard implementation
        }
    }
}

