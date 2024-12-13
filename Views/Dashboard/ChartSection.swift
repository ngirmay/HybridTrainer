//
//  ChartSection.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/12/24.
//

// Views/Dashboard/ChartSection.swift
// ChartSection.swift
import SwiftUI

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
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
        }
    }
}

