//
//  TrainingView.swift
//  HybridTrainer
//

import SwiftUI
import SwiftData
import Models

public struct TrainingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TrainingSession.date, order: .reverse) private var sessions: [TrainingSession]
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            Group {
                if sessions.isEmpty {
                    ContentUnavailableView {
                        Label("No Training Sessions", systemImage: "calendar")
                    } description: {
                        Text("Plan your training sessions to stay on track")
                    } actions: {
                        Button(action: addSampleSession) {
                            Text("Add Session")
                        }
                    }
                } else {
                    List {
                        ForEach(sessions) { session in
                            TrainingSessionRow(session: session)
                                .listRowBackground(Theme.Colors.cardBackground)
                        }
                        .onDelete(perform: deleteSessions)
                    }
                    .scrollContentBackground(.hidden)
                    .background(Theme.Colors.background)
                }
            }
            .navigationTitle("Training")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addSampleSession) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteSessions(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(sessions[index])
        }
    }
    
    private func addSampleSession() {
        let session = TrainingSession(
            type: .run,
            date: Date().addingTimeInterval(60*60*24), // Tomorrow
            plannedDuration: 3600, // 1 hour
            plannedDistance: 10000, // 10km
            notes: "Easy run focusing on form"
        )
        modelContext.insert(session)
    }
}

struct TrainingSessionRow: View {
    let session: TrainingSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: session.type.icon)
                    .foregroundStyle(session.type.displayColor)
                Text(session.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.headline)
            }
            
            if let distance = session.plannedDistance {
                Text("\(Int(distance/1000)) km")
                    .foregroundStyle(.secondary)
            }
            
            if let duration = session.plannedDuration {
                Text("\(Int(duration/60)) minutes")
                    .foregroundStyle(.secondary)
            }
            
            if let notes = session.notes {
                Text(notes)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TrainingView()
        .modelContainer(for: [TrainingSession.self], inMemory: true)
} 