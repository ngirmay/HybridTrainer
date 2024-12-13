//
//  MetricsSection.swift
//  HybridTrainer
//

import SwiftUI

struct MetricsSection: View {
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            MetricCard(
                title: "Weekly Hours",
                value: totalWeeklyHours,
                trend: "+5%"
            )
            
            MetricCard(
                title: "Weekly TSS",
                value: latestWeekTSS,
                trend: "+12%"
            )
            
            MetricCard(
                title: "Fitness (CTL)",
                value: currentCTL,
                trend: "+3%"
            )
            
            MetricCard(
                title: "Fatigue (ATL)",
                value: currentATL,
                trend: "-2%"
            )
        }
    }
    
    private var totalWeeklyHours: String {
        guard let latestWeek = viewModel.weeklyVolumes.first else { return "0" }
        let total = latestWeek.swimHours + latestWeek.bikeHours + latestWeek.runHours
        return String(format: "%.1f", total)
    }
    
    private var latestWeekTSS: String {
        guard let latestWeek = viewModel.weeklyVolumes.first else { return "0" }
        return String(format: "%.0f", latestWeek.totalTSS)
    }
    
    private var currentCTL: String {
        guard let latest = viewModel.trainingLoad.last else { return "0" }
        return String(format: "%.0f", latest.ctl)
    }
    
    private var currentATL: String {
        guard let latest = viewModel.trainingLoad.last else { return "0" }
        return String(format: "%.0f", latest.atl)
    }
}

