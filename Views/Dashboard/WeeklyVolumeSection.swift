//
//  WeeklyVolumeSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts
import SwiftData

struct WeeklyVolumeSection: View {
    let weeklyVolumes: [WeeklyVolume]
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
    
    var body: some View {
        ChartSection(title: "Weekly Volume") {
            if weeklyVolumes.isEmpty {
                Text("No data available")
                    .foregroundColor(.secondary)
            } else {
                VStack {
                    Chart {
                        ForEach(weeklyVolumes.prefix(8)) { volume in
                            BarMark(
                                x: .value("Week", dateFormatter.string(from: volume.week)),
                                y: .value("Hours", volume.swimHours)
                            )
                            .foregroundStyle(Color.blue)
                            
                            BarMark(
                                x: .value("Week", dateFormatter.string(from: volume.week)),
                                y: .value("Hours", volume.bikeHours)
                            )
                            .foregroundStyle(Color.green)
                            
                            BarMark(
                                x: .value("Week", dateFormatter.string(from: volume.week)),
                                y: .value("Hours", volume.runHours)
                            )
                            .foregroundStyle(Color.orange)
                        }
                    }
                    .frame(height: 200)
                    
                    HStack(spacing: 16) {
                        Label("Swim", systemImage: "circle.fill").foregroundColor(.blue)
                        Label("Bike", systemImage: "circle.fill").foregroundColor(.green)
                        Label("Run", systemImage: "circle.fill").foregroundColor(.orange)
                    }
                    .font(.caption)
                }
            }
        }
    }
}

#Preview {
    WeeklyVolumeSection(weeklyVolumes: [])
}
