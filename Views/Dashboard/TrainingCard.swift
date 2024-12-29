//
//  TrainingCard.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI
import SwiftData

struct TrainingCard: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var blocks: [TrainingBlock]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Training")
                .font(.headline)
            
            if blocks.isEmpty {
                EmptyTrainingView()
            } else {
                TrainingBlocksList(blocks: blocks)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

private struct TrainingBlocksList: View {
    let blocks: [TrainingBlock]
    
    var body: some View {
        ForEach(blocks) { block in
            VStack(alignment: .leading) {
                Text(block.phase.rawValue.capitalized)
                    .font(.subheadline)
                Text(block.focus)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if let currentWeek = block.weeks.first(where: { 
                    $0.startDate <= Date() && 
                    Calendar.current.date(byAdding: .weekOfYear, value: 1, to: $0.startDate)! > Date() 
                }) {
                    WeekProgressView(week: currentWeek)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

private struct WeekProgressView: View {
    let week: TrainingWeek
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Week \(week.weekNumber)")
                .font(.caption)
            
            if let metrics = week.metrics {
                HStack {
                    MetricView(value: metrics.runMileage ?? 0, unit: "mi", type: "Run")
                    MetricView(value: metrics.bikeMileage ?? 0, unit: "mi", type: "Bike")
                    MetricView(value: metrics.swimMileage ?? 0, unit: "m", type: "Swim")
                }
            }
        }
    }
}

private struct MetricView: View {
    let value: Double
    let unit: String
    let type: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(type)
                .font(.caption2)
            Text("\(Int(value))\(unit)")
                .font(.caption)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct EmptyTrainingView: View {
    var body: some View {
        Text("No training blocks")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}
