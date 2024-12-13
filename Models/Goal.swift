//
//  Goal.swift
//  HybridTrainer
//

import Foundation
import SwiftData

@Model
final class Goal {
    var id: UUID
    var title: String
    var targetDate: Date
    var isCompleted: Bool
    
    init(title: String, targetDate: Date) {
        self.id = UUID()
        self.title = title
        self.targetDate = targetDate
        self.isCompleted = false
    }
}


