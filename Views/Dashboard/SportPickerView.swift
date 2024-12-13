//
//  SportPickerView.swift
//  HybridTrainer
//

import SwiftUI

struct SportPickerView: View {
    @Binding var selectedType: WorkoutType?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                Button(action: { selectedType = nil }) {
                    HStack {
                        Image(systemName: "infinity")
                        Text("All")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(selectedType == nil ? Color.gray.opacity(0.2) : Color.clear)
                    .foregroundColor(selectedType == nil ? .primary : .secondary)
                    .cornerRadius(8)
                }
                
                ForEach(WorkoutType.allCases, id: \.self) { type in
                    SportButton(
                        type: type,
                        isSelected: selectedType == type,
                        action: { selectedType = type }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SportButton: View {
    let type: WorkoutType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: type.icon)
                Text(type.rawValue.capitalized)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color(type.iconColor).opacity(0.2) : Color.clear)
            .foregroundColor(isSelected ? Color(type.iconColor) : .primary)
            .cornerRadius(8)
        }
    }
}

#Preview {
    SportPickerView(selectedType: .constant(.swim))
}

