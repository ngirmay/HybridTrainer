//
//  WorkoutViews.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI
import SwiftData
import Models

public struct WorkoutsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Workout.startDate, order: .reverse) private var workouts: [Workout]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            Group {
                if workouts.isEmpty {
                    ContentUnavailableView {
                        Label("No Workouts", systemImage: "figure.run")
                    } description: {
                        Text("Your completed workouts will appear here")
                    } actions: {
                        Button(action: addSampleWorkout) {
                            Text("Add Workout")
                        }
                    }
                } else {
                    List {
                        ForEach(workouts) { workout in
                            NavigationLink(value: workout) {
                                WorkoutRow(workout: workout)
                            }
                        }
                        .onDelete(perform: deleteWorkouts)
                    }
                }
            }
            .navigationTitle("Workouts")
            .navigationDestination(for: Workout.self) { workout in
                WorkoutDetailView(workout: workout)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addSampleWorkout) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteWorkouts(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(workouts[index])
        }
    }
    
    private func addSampleWorkout() {
        let workout = Workout(
            type: .run,
            startDate: Date(),
            duration: 3600,  // 1 hour
            distance: 10000, // 10km
            calories: 800
        )
        modelContext.insert(workout)
    }
}

struct WorkoutDetailView: View {
    let workout: Workout
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: workout.type.icon)
                        .foregroundStyle(workout.type.displayColor)
                        .font(.title2)
                    Text(workout.type.rawValue.capitalized)
                        .font(.headline)
                    Spacer()
                    Text(workout.startDate.formatted(date: .abbreviated, time: .shortened))
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Stats") {
                LabeledContent("Duration", value: formatDuration(workout.duration))
                if let distance = workout.distance {
                    LabeledContent("Distance", value: String(format: "%.1f km", distance / 1000))
                }
                if let calories = workout.calories {
                    LabeledContent("Calories", value: "\(Int(calories)) kcal")
                }
                if let distance = workout.distance, workout.duration > 0 {
                    let paceInMinutesPerKm = (workout.duration / 60) / (distance / 1000)
                    LabeledContent("Average Pace", value: String(format: "%.1f min/km", paceInMinutesPerKm))
                }
            }
        }
        .navigationTitle("Workout Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return String(format: "%d:%02d", hours, minutes)
    }
}

#Preview {
    WorkoutsView()
        .modelContainer(for: [Workout.self], inMemory: true)
}

