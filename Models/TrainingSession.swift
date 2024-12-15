//
//  TrainingSession.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
public final class TrainingSession {
    public var id: UUID
    public var date: Date
    public var notes: String?
    public var workouts: [Workout]
    
    public init(date: Date) {
        self.id = UUID()
        self.date = date
        self.workouts = []
    }
}

