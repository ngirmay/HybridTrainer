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
                Chart(weeklyVolumes) { volume in
                    BarMark(
                        x: .value("Week", volume.week, unit: .week),
                        y: .value("Hours", volume.swimHours + volume.bikeHours + volume.runHours)
                    )
                    .foregroundStyle(by: .value("Sport", "Total"))
                }
                .frame(height: 200)
                .chartForegroundStyleScale([
                    "Total": Color.accentColor
                ])
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
        )
    ])
    .padding()
    .background(Color(.systemGray6))
}
