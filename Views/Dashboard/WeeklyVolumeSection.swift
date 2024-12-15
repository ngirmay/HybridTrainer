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
                            x: .value("Week", volume.week, unit: .week),
                            y: .value("Hours", volume.swimHours)
                        )
                        .foregroundStyle(.blue)
                        
                        BarMark(
                            x: .value("Week", volume.week, unit: .week),
                            y: .value("Hours", volume.bikeHours)
                        )
                        .foregroundStyle(.green)
                        
                        BarMark(
                            x: .value("Week", volume.week, unit: .week),
                            y: .value("Hours", volume.runHours)
                        )
                        .foregroundStyle(.orange)
                    }
                }
                .frame(height: 200)
                .chartLegend(position: .bottom) {
                    HStack(spacing: 16) {
                        Label("Swim", systemImage: "circle.fill")
                            .foregroundStyle(.blue)
                        Label("Bike", systemImage: "circle.fill")
                            .foregroundStyle(.green)
                        Label("Run", systemImage: "circle.fill")
                            .foregroundStyle(.orange)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
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
