//
//  SportPickerView.swift
//  HybridTrainer
//

import SwiftUI

struct SportPickerView: View {
    @Binding var selectedSport: WorkoutType?
    let sports: [WorkoutType?] = [nil, .swim, .bike, .run, .strength]
    
    var body: some View {
        Picker("Sport", selection: $selectedSport) {
            Text("All").tag(WorkoutType?.none)
            Text("Swim").tag(WorkoutType?.some(.swim))
            Text("Bike").tag(WorkoutType?.some(.bike))
            Text("Run").tag(WorkoutType?.some(.run))
            Text("Strength").tag(WorkoutType?.some(.strength))
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

