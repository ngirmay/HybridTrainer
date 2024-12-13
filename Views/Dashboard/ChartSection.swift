//
//  ChartSection.swift
//  HybridTrainer
//

import SwiftUI
import Charts

struct ChartSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    ChartSection(title: "Training Load") {
        // Placeholder for the content
    }
    .modelContainer(for: WeeklyVolume.self, inMemory: true)
}
