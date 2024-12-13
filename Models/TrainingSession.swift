//
//  TrainingSession.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
final class TrainingSession {
    var id: UUID
    var date: Date
    var notes: String?
    var workouts: [Workout]
    
    init(date: Date) {
        self.id = UUID()
        self.date = date
        self.workouts = []
    }
}

