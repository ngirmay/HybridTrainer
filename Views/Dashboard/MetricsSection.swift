//
//  MetricsSection.swift
//  HybridTrainer
//

import SwiftUI
import Models

public struct MetricsSection: View {
    let workouts: [Workout]
    
    public init(workouts: [Workout]) {
        self.workouts = workouts
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            ForEach(WorkoutType.allCases, id: \.self) { type in
                let typeWorkouts = workouts.filter { $0.type == type }
                MetricCard(
                    icon: type.icon,
                    iconColor: typeColor(for: type),
                    trend: calculateTrend(for: typeWorkouts),
                    workouts: typeWorkouts
                )
            }
        }
    }
    
    private func typeColor(for type: WorkoutType) -> Color {
        switch type {
        case .swim: return .blue
        case .bike: return .green
        case .run: return .orange
        case .strength: return .purple
        }
    }
    
    private func calculateTrend(for workouts: [Workout]) -> TrendDirection {
        guard workouts.count >= 2 else { return .neutral }
        
        // Sort workouts by date
        let sortedWorkouts = workouts.sorted { $0.startDate > $1.startDate }
        
        // Compare the two most recent workouts
        let latest = sortedWorkouts[0]
        let previous = sortedWorkouts[1]
        
        // Compare durations
        if latest.duration > previous.duration {
            return .increasing
        } else if latest.duration < previous.duration {
            return .decreasing
        } else {
            return .neutral
        }
    }
}

#Preview {
    MetricsSection(workouts: [
        Workout(
            type: .run,
            startDate: Date(),
            duration: 3600,
            distance: 10000
        ),
        Workout(
            type: .run,
            startDate: Date().addingTimeInterval(-86400),
            duration: 3000,
            distance: 8000
        )
    ])
    .padding()
    .background(Color(.systemGray6))
}

