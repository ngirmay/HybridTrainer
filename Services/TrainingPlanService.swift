import Foundation
import Models

class TrainingPlanService {
    static let shared = TrainingPlanService()
    
    struct PlanMetadata {
        let startDate: Date
        let raceDate: Date
        let phases: [TrainingPhase: DateInterval]
        let targetTime: TimeInterval // 10:30:00
    }
    
    func loadPlan(_ planId: String) async throws -> (metadata: PlanMetadata, weeks: [TrainingWeek]) {
        switch planId {
        case "plan_a":
            return try generateIronmanPlan()
        default:
            throw TrainingError.planNotFound
        }
    }
    
    private func generateIronmanPlan() throws -> (PlanMetadata, [TrainingWeek]) {
        // Your specific dates from the spreadsheet
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let startDate = dateFormatter.date(from: "11/28/2022"),
              let raceDate = dateFormatter.date(from: "07/23/2023") else {
            throw TrainingError.invalidDates
        }
        
        // Create phase intervals
        let calendar = Calendar.current
        let baseEnd = calendar.date(from: DateComponents(year: 2023, month: 1, day: 22))!
        let build1End = calendar.date(from: DateComponents(year: 2023, month: 3, day: 19))!
        let build2End = calendar.date(from: DateComponents(year: 2023, month: 5, day: 14))!
        let speedEnd = calendar.date(from: DateComponents(year: 2023, month: 7, day: 2))!
        
        let phases: [TrainingPhase: DateInterval] = [
            .base: DateInterval(start: startDate, end: baseEnd),
            .build: DateInterval(start: baseEnd, end: build2End),
            .speed: DateInterval(start: build2End, end: speedEnd),
            .taper: DateInterval(start: speedEnd, end: raceDate)
        ]
        
        let metadata = PlanMetadata(
            startDate: startDate,
            raceDate: raceDate,
            phases: phases,
            targetTime: 10.5 * 3600 // 10:30:00
        )
        
        // Generate weeks
        var weeks: [TrainingWeek] = []
        var currentDate = startDate
        var weekNumber = 1
        
        while currentDate < raceDate {
            let week = generateWeek(
                startDate: currentDate,
                weekNumber: weekNumber,
                phase: currentPhase(for: currentDate, in: phases)
            )
            weeks.append(week)
            
            currentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
            weekNumber += 1
        }
        
        return (metadata, weeks)
    }
    
    private func currentPhase(for date: Date, in phases: [TrainingPhase: DateInterval]) -> TrainingPhase {
        for (phase, interval) in phases {
            if interval.contains(date) {
                return phase
            }
        }
        return .base
    }
    
    private func generateWeek(startDate: Date, weekNumber: Int, phase: TrainingPhase) -> TrainingWeek {
        // Convert your spreadsheet data to TrainingWeek objects
        // Example for base phase:
        let sessions = (0...6).map { dayOffset -> TrainingDay in
            let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)!
            
            // Map your spreadsheet workouts based on the day of week
            let workouts: [PlannedWorkout] = {
                switch dayOffset {
                case 0: // Monday
                    return [createWorkout(type: .swim, description: "Swim 2")]
                case 1: // Tuesday
                    return [createWorkout(type: .swim, description: "Swim 2 - Strength")]
                case 2: // Wednesday
                    return [] // Rest
                case 3: // Thursday
                    return [createWorkout(type: .swim, description: "Swim 1")]
                case 4: // Friday
                    return [
                        createWorkout(type: .run, description: "Run 2 (MAF test - 5 miles)"),
                        createWorkout(type: .bike, description: "Easy spin")
                    ]
                case 5: // Saturday
                    return [createWorkout(type: .swim, description: "Swim 2 - Strength")]
                case 6: // Sunday
                    return [createWorkout(type: .run, description: "Run 2")]
                default:
                    return []
                }
            }()
            
            return TrainingDay(
                id: UUID(),
                date: date,
                workouts: workouts,
                notes: nil
            )
        }
        
        return TrainingWeek(
            id: UUID(),
            blockId: UUID(),
            weekNumber: weekNumber,
            startDate: startDate,
            sessions: sessions,
            metrics: WeeklyMetrics(
                runMileage: 10,
                bikeMileage: 0,
                swimMileage: 5,
                isClean: true
            )
        )
    }
    
    private func createWorkout(type: WorkoutType, description: String) -> PlannedWorkout {
        PlannedWorkout(
            id: UUID(),
            type: type,
            description: description,
            intensity: .moderate,
            targetDistance: nil,
            targetDuration: nil,
            targetPace: nil,
            isCompleted: false
        )
    }
}

enum TrainingError: Error {
    case planNotFound
    case invalidDates
} 