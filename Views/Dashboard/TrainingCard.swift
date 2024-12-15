//
//  TrainingCard.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI

struct TrainingCard: View {
    let session: TrainingSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: session.type.icon)
                .font(.title)
                .foregroundStyle(session.type.displayColor)
            Text(session.title)
                .font(.headline)
            Text(session.subtitle)
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
