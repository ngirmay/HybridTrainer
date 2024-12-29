import Foundation
import SwiftData
import Models

class TrainingPlanService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func createPlan(_ planId: String) async throws {
        switch planId {
        case "plan_a":
            try await createIronmanPlan()
        default:
            throw TrainingError.planNotFound
        }
    }
    
    private func createIronmanPlan() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let startDate = dateFormatter.date(from: "11/28/2022"),
              let raceDate = dateFormatter.date(from: "07/23/2023") else {
            throw TrainingError.invalidDates
        }
        
        // Create blocks
        let blocks = try generateTrainingBlocks(startDate: startDate, raceDate: raceDate)
        blocks.forEach { modelContext.insert($0) }
        
        // Create sessions
        let sessions = try generateTrainingSessions(startDate: startDate, raceDate: raceDate)
        sessions.forEach { modelContext.insert($0) }
        
        try modelContext.save()
    }
    
    private func generateTrainingBlocks(startDate: Date, raceDate: Date) throws -> [TrainingBlock] {
        let calendar = Calendar.current
        let baseEnd = calendar.date(from: DateComponents(year: 2023, month: 1, day: 22))!
        let build1End = calendar.date(from: DateComponents(year: 2023, month: 3, day: 19))!
        let build2End = calendar.date(from: DateComponents(year: 2023, month: 5, day: 14))!
        let speedEnd = calendar.date(from: DateComponents(year: 2023, month: 7, day: 2))!
        
        return [
            TrainingBlock(phase: .base, startDate: startDate, endDate: baseEnd, 
                         focus: "Swim (Adaption Strength)", targetWeight: 165, targetBodyFat: 12),
            TrainingBlock(phase: .build, startDate: baseEnd, endDate: build2End, 
                         focus: "Bike/Run (Max Strength)", targetWeight: 160, targetBodyFat: 10),
            TrainingBlock(phase: .speed, startDate: build2End, endDate: speedEnd, 
                         focus: "Race Specific", targetWeight: 155, targetBodyFat: 8),
            TrainingBlock(phase: .taper, startDate: speedEnd, endDate: raceDate, 
                         focus: "Race Preparation", targetWeight: 155, targetBodyFat: 7)
        ]
    }
    
    private func generateTrainingSessions(startDate: Date, raceDate: Date) throws -> [TrainingSession] {
        var sessions: [TrainingSession] = []
        var currentDate = startDate
        var weekNumber = 1
        
        while currentDate < raceDate {
            // Example: Monday - Swim
            let session = TrainingSession(
                type: .swim,
                date: currentDate,
                plannedWorkouts: [
                    PlannedWorkout(
                        type: .swim,
                        description: "Swim 2",
                        intensity: .moderate,
                        targetDistance: 2000
                    )
                ],
                weekNumber: weekNumber
            )
            sessions.append(session)
            
            // Move to next day
            if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
                if Calendar.current.component(.weekday, from: currentDate) == 2 { // Monday
                    weekNumber += 1
                }
            }
        }
        
        return sessions
    }
}

enum TrainingError: Error {
    case planNotFound
    case invalidDates
} 