//
//  WeeklyVolumeSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts
import Models

public struct WeeklyVolumeSection: View {
    let weeklyVolumes: [WeeklyVolume]
    
    public init(weeklyVolumes: [WeeklyVolume]) {
        self.weeklyVolumes = weeklyVolumes
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Weekly Volume")
                .font(.headline)
            
            if weeklyVolumes.isEmpty {
                Text("No data available")
                    .foregroundStyle(.secondary)
            } else {
                Chart {
                    ForEach(weeklyVolumes) { volume in
                        BarMark(
                            x: .value("Week", volume.week, unit: .weekOfYear),
                            y: .value("Hours", volume.swimHours)
                        )
                        .foregroundStyle(WorkoutType.swim.displayColor)
                        
                        BarMark(
                            x: .value("Week", volume.week, unit: .weekOfYear),
                            y: .value("Hours", volume.bikeHours)
                        )
                        .foregroundStyle(WorkoutType.bike.displayColor)
                        
                        BarMark(
                            x: .value("Week", volume.week, unit: .weekOfYear),
                            y: .value("Hours", volume.runHours)
                        )
                        .foregroundStyle(WorkoutType.run.displayColor)
                    }
                }
                .frame(height: 200)
                .chartLegend(position: .bottom) {
                    HStack(spacing: 16) {
                        Label("Swim", systemImage: "circle.fill")
                            .foregroundStyle(WorkoutType.swim.displayColor)
                        Label("Bike", systemImage: "circle.fill")
                            .foregroundStyle(WorkoutType.bike.displayColor)
                        Label("Run", systemImage: "circle.fill")
                            .foregroundStyle(WorkoutType.run.displayColor)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.Metrics.cornerRadius)
    }
}

#Preview {
    WeeklyVolumeSection(weeklyVolumes: [
        WeeklyVolume(
            week: Date(),
            swimHours: 2,
            bikeHours: 3,
            runHours: 1
        ),
        WeeklyVolume(
            week: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
            swimHours: 1.5,
            bikeHours: 4,
            runHours: 2
        )
    ])
    .padding()
    .background(Color(.systemGray6))
}
