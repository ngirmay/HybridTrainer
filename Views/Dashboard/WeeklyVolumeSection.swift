//
//  WeeklyVolumeSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts

struct WeeklyVolumeSection: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var selectedSport: WorkoutType?

    var body: some View {
        let data = viewModel.weeklyVolume(for: selectedSport)
        
        ChartSection(title: "Weekly Volume") {
            Chart(data, id: \.week) { item in
                BarMark(
                    x: .value("Week", item.week),
                    y: .value("Hours", item.duration / 3600)
                )
            }
            .frame(height: 200)
            .chartXAxis {
                AxisMarks() // Default axis marks
            }
            .chartYAxis {
                AxisMarks()
            }
        }
    }
}
