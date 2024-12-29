import Foundation
import SwiftData

struct PreviewData {
    static func createPreviewContainer() -> ModelContainer {
        let schema = Schema([
            TrainingSession.self,
            PlannedWorkout.self,
            TrainingBlock.self,
            TrainingWeek.self,
            TrainingDay.self,
            WeeklyMetrics.self
        ])
        
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        
        do {
            let container = try ModelContainer(
                for: schema,
                configurations: configuration
            )
            
            // Add sample data
            let context = container.mainContext
            try populateSampleData(context: context)
            
            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }
    
    static func populateSampleData(context: ModelContext) throws {
        // Create a training block
        let block = TrainingBlock(
            phase: .base,
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
            focus: "Build aerobic base"
        )
        
        // Create some training weeks
        for weekOffset in 0..<4 {
            let startDate = Calendar.current.date(byAdding: .weekOfYear, value: weekOffset, to: Date())!
            
            let week = TrainingWeek(
                blockId: block.id,
                weekNumber: weekOffset + 1,
                startDate: startDate
            )
            
            // Add some training days
            for dayOffset in 0..<7 {
                if let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate) {
                    let workout = PlannedWorkout(
                        type: .run,
                        description: "Easy run",
                        intensity: .easy,
                        targetDistance: 5000,
                        targetDuration: 1800
                    )
                    
                    let day = TrainingDay(
                        date: date,
                        workouts: [workout]
                    )
                    
                    week.sessions.append(day)
                }
            }
            
            // Add metrics
            let metrics = WeeklyMetrics(
                runMileage: 20.0,
                bikeMileage: 100.0,
                swimMileage: 4000.0
            )
            week.metrics = metrics
            
            block.weeks.append(week)
        }
        
        context.insert(block)
        try context.save()
    }
} 