//
//  TrainingDistributionSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts

struct TrainingDistributionSection: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var selectedSport: WorkoutType?

    var body: some View {
        let distribution = viewModel.volumeByType
        
        ChartSection(title: "Training Distribution") {
            Chart(distribution, id: \.type) { item in
                SectorMark(
                    angle: .value("Duration", item.duration),
                    innerRadius: .ratio(0.5)
                )
                .foregroundStyle(by: .value("Type", item.type.rawValue))
                .opacity(selectedSport == nil || selectedSport == item.type ? 1.0 : 0.3)
            }
            .frame(height: 200)
            .chartLegend(position: .bottom)
        }
    }
}
