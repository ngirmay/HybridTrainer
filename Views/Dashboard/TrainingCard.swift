//
//  TrainingCard.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI

struct TrainingCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(iconColor)
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 140)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
