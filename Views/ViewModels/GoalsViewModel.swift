import SwiftUI
import SwiftData
import Models

@Observable
class GoalsViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    
    init() { }
    
    func deleteGoal(_ goal: Goal) {
        modelContext.delete(goal)
    }
    
    func addHalfIronmanGoals() {
        // June 15th, 2025
        let raceDate = Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 15))!
        let goals = Goal.halfIronman(targetDate: raceDate)
        goals.forEach { modelContext.insert($0) }
    }
    
    func addGoal(name: String, type: WorkoutType, targetValue: Double, targetDate: Date, notes: String?) {
        let goal = Goal(
            name: name,
            targetDate: targetDate,
            type: type,
            targetValue: targetValue,
            notes: notes
        )
        modelContext.insert(goal)
    }
} 