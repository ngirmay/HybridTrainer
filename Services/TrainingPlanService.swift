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
        
        // Create training blocks
        let blocks = try generateTrainingBlocks(startDate: startDate, raceDate: raceDate)
        
        // Generate all training sessions
        var allSessions: [TrainingSession] = []
        var currentDate = startDate
        var weekNumber = 1
        
        while currentDate < raceDate {
            let currentPhase = determinePhase(for: currentDate, in: blocks)
            let weekSessions = try generateWeekSessions(
                startDate: currentDate,
                weekNumber: weekNumber,
                phase: currentPhase
            )
            allSessions.append(contentsOf: weekSessions)
            
            if let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate) {
                currentDate = nextWeek
                weekNumber += 1
            } else {
                break
            }
        }
        
        // Save everything to the context
        blocks.forEach { modelContext.insert($0) }
        allSessions.forEach { modelContext.insert($0) }
        
        try modelContext.save()
    }
    
    private func generateTrainingBlocks(startDate: Date, raceDate: Date) throws -> [TrainingBlock] {
        let calendar = Calendar.current
        let baseEnd = calendar.date(from: DateComponents(year: 2023, month: 1, day: 22))!
        let build1End = calendar.date(from: DateComponents(year: 2023, month: 3, day: 19))!
        let build2End = calendar.date(from: DateComponents(year: 2023, month: 5, day: 14))!
        let speedEnd = calendar.date(from: DateComponents(year: 2023, month: 7, day: 2))!
        
        return [
            TrainingBlock(
                phase: .base,
                startDate: startDate,
                endDate: baseEnd,
                focus: "Swim (Adaption Strength)",
                targetWeight: 165,
                targetBodyFat: 12
            ),
            TrainingBlock(
                phase: .build,
                startDate: baseEnd,
                endDate: build2End,
                focus: "Bike/Run (Max Strength)",
                targetWeight: 160,
                targetBodyFat: 10
            ),
            TrainingBlock(
                phase: .speed,
                startDate: build2End,
                endDate: speedEnd,
                focus: "Race Specific",
                targetWeight: 155,
                targetBodyFat: 8
            ),
            TrainingBlock(
                phase: .taper,
                startDate: speedEnd,
                endDate: raceDate,
                focus: "Race Preparation",
                targetWeight: 155,
                targetBodyFat: 7
            )
        ]
    }
    
    private func generateWeekSessions(startDate: Date, weekNumber: Int, phase: TrainingPhase) throws -> [TrainingSession] {
        let calendar = Calendar.current
        var sessions: [TrainingSession] = []
        
        // Get the training schedule for this phase and week
        let schedule = getTrainingSchedule(for: phase, weekNumber: weekNumber)
        
        // Create sessions for each day of the week
        for dayOffset in 0...6 {
            guard let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate) else {
                continue
            }
            
            let dayOfWeek = calendar.component(.weekday, from: date) // 1 = Sunday, 2 = Monday, etc.
            let workouts = schedule[dayOfWeek]?.map { workoutInfo in
                PlannedWorkout(
                    type: workoutInfo.type,
                    description: workoutInfo.description,
                    intensity: workoutInfo.intensity,
                    targetDistance: workoutInfo.distance,
                    targetDuration: workoutInfo.duration
                )
            } ?? []
            
            if !workouts.isEmpty {
                let session = TrainingSession(
                    type: workouts[0].type, // Primary workout type
                    date: date,
                    plannedWorkouts: workouts,
                    weekNumber: weekNumber,
                    phase: phase
                )
                sessions.append(session)
            }
        }
        
        return sessions
    }
    
    private func determinePhase(for date: Date, in blocks: [TrainingBlock]) -> TrainingPhase {
        for block in blocks {
            if (block.startDate...block.endDate).contains(date) {
                return block.phase
            }
        }
        return .base // Default to base phase
    }
    
    private func getTrainingSchedule(for phase: TrainingPhase, weekNumber: Int) -> [Int: [(type: WorkoutType, description: String, intensity: WorkoutIntensity, distance: Double?, duration: TimeInterval?)]] {
        // 1 = Sunday, 2 = Monday, etc.
        switch phase {
        case .base:
            return [
                2: [ // Monday
                    (type: .swim, description: "Swim 2", intensity: .moderate, distance: 2000, duration: nil)
                ],
                3: [ // Tuesday
                    (type: .swim, description: "Swim 2 - Strength", intensity: .moderate, distance: 2000, duration: nil)
                ],
                5: [ // Thursday
                    (type: .swim, description: "Swim 1", intensity: .easy, distance: 1500, duration: nil)
                ],
                6: [ // Friday
                    (type: .run, description: "Run 2 (MAF test - 5 miles)", intensity: .moderate, distance: 8046.72, duration: nil),
                    (type: .bike, description: "Easy spin", intensity: .easy, distance: nil, duration: 3600)
                ],
                7: [ // Saturday
                    (type: .swim, description: "Swim 2 - Strength", intensity: .moderate, distance: 2000, duration: nil)
                ]
            ]
        // Add other phase schedules...
        default:
            return [:] // Empty schedule for other phases for now
        }
    }
}

enum TrainingError: Error {
    case planNotFound
    case invalidDates
} 