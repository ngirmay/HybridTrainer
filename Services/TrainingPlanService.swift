import Foundation
import SwiftData

public class TrainingPlanService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Plan Creation
    func createPlan(_ planId: String) async throws {
        switch planId {
        case "ironman_base":
            try await createIronmanPlan(phase: .base)
        case "ironman_build":
            try await createIronmanPlan(phase: .build)
        case "ironman_peak":
            try await createIronmanPlan(phase: .speed)
        case "ironman_taper":
            try await createIronmanPlan(phase: .taper)
        default:
            throw TrainingError.planNotFound
        }
    }
    
    // MARK: - Plan Generation
    private func createIronmanPlan(phase: TrainingPhase) async throws {
        let block = try await generateTrainingBlock(phase: phase)
        try await generateWeeks(for: block)
        try modelContext.save()
    }
    
    private func generateTrainingBlock(phase: TrainingPhase) async throws -> TrainingBlock {
        let block = TrainingBlock(
            phase: phase,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .weekOfYear, value: 4, to: Date())!,
            focus: getFocusForPhase(phase)
        )
        modelContext.insert(block)
        return block
    }
    
    private func generateWeeks(for block: TrainingBlock) async throws {
        var currentDate = block.startDate
        var weekNumber = 1
        
        while currentDate < block.endDate {
            let week = try await generateTrainingWeek(
                blockId: block.id,
                weekNumber: weekNumber,
                startDate: currentDate,
                phase: block.phase
            )
            
            block.weeks.append(week)
            
            if let nextWeek = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate) {
                currentDate = nextWeek
                weekNumber += 1
            }
        }
    }
    
    private func generateTrainingWeek(
        blockId: UUID,
        weekNumber: Int,
        startDate: Date,
        phase: TrainingPhase
    ) async throws -> TrainingWeek {
        let week = TrainingWeek(
            blockId: blockId,
            weekNumber: weekNumber,
            startDate: startDate
        )
        
        // Generate training days
        var currentDate = startDate
        for dayOffset in 0..<7 {
            if let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate) {
                let workouts = try generateWorkouts(for: date, phase: phase, weekNumber: weekNumber)
                if !workouts.isEmpty {
                    let day = TrainingDay(date: date, workouts: workouts)
                    week.sessions.append(day)
                }
            }
        }
        
        // Create weekly metrics
        let metrics = WeeklyMetrics(
            runMileage: getTargetRunMileage(phase: phase, week: weekNumber),
            bikeMileage: getTargetBikeMileage(phase: phase, week: weekNumber),
            swimMileage: getTargetSwimMileage(phase: phase, week: weekNumber)
        )
        week.metrics = metrics
        
        modelContext.insert(week)
        return week
    }
    
    // MARK: - Workout Generation
    private func generateWorkouts(
        for date: Date,
        phase: TrainingPhase,
        weekNumber: Int
    ) throws -> [PlannedWorkout] {
        let dayOfWeek = Calendar.current.component(.weekday, from: date)
        let schedule = getTrainingSchedule(for: phase, weekNumber: weekNumber)
        
        return schedule[dayOfWeek]?.map { workout in
            PlannedWorkout(
                type: workout.type,
                description: workout.description,
                intensity: workout.intensity,
                targetDistance: workout.distance,
                targetDuration: workout.duration
            )
        } ?? []
    }
    
    // MARK: - Helper Methods
    private func getFocusForPhase(_ phase: TrainingPhase) -> String {
        switch phase {
        case .base: return "Build aerobic base and technique"
        case .build: return "Increase volume and intensity"
        case .speed: return "Race-specific preparation"
        case .taper: return "Recovery and race preparation"
        }
    }
    
    private func getTargetRunMileage(phase: TrainingPhase, week: Int) -> Double {
        switch phase {
        case .base: return Double(20 + (week * 2))
        case .build: return Double(30 + (week * 3))
        case .speed: return Double(40)
        case .taper: return Double(20)
        }
    }
    
    // Similar methods for bike and swim mileage...
    
    // Add new block-based training plan methods
    func createTrainingBlock(
        phase: TrainingPhase,
        startDate: Date,
        endDate: Date,
        focus: String
    ) throws -> TrainingBlock {
        let block = TrainingBlock(
            phase: phase,
            startDate: startDate,
            endDate: endDate,
            focus: focus
        )
        
        modelContext.insert(block)
        return block
    }
    
    func addWeekToBlock(
        _ block: TrainingBlock,
        weekNumber: Int,
        startDate: Date
    ) throws -> TrainingWeek {
        let week = TrainingWeek(
            blockId: block.id,
            weekNumber: weekNumber,
            startDate: startDate
        )
        
        block.weeks.append(week)
        return week
    }
    
    func addWorkoutToDay(
        _ day: TrainingDay,
        type: WorkoutType,
        description: String,
        intensity: WorkoutIntensity,
        targetDistance: Double? = nil,
        targetDuration: TimeInterval? = nil
    ) throws -> PlannedWorkout {
        let workout = PlannedWorkout(
            type: type,
            description: description,
            intensity: intensity,
            targetDistance: targetDistance,
            targetDuration: targetDuration
        )
        
        day.workouts.append(workout)
        return workout
    }
}

// MARK: - Supporting Types
enum TrainingError: Error {
    case planNotFound
    case invalidDates
    case failedToGenerateWorkouts
}

struct WorkoutTemplate {
    let type: WorkoutType
    let description: String
    let intensity: WorkoutIntensity
    let distance: Double?
    let duration: TimeInterval?
} 