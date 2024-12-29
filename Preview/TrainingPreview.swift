import SwiftUI
import SwiftData

struct TrainingPreview {
    static var previewContainer: ModelContainer {
        let schema = Schema([
            TrainingBlock.self,
            TrainingWeek.self,
            TrainingDay.self,
            WeeklyMetrics.self
        ])
        
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            let container = try ModelContainer(for: schema, configurations: configuration)
            let context = container.mainContext
            
            // Add sample data
            let block = TrainingBlock(
                phase: .base,
                startDate: Date(),
                endDate: Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
                focus: "Build aerobic base"
            )
            
            let week = TrainingWeek(
                blockId: block.id,
                weekNumber: 1,
                startDate: Date()
            )
            
            let metrics = WeeklyMetrics(
                runMileage: 20,
                bikeMileage: 100,
                swimMileage: 4000
            )
            
            week.metrics = metrics
            block.weeks.append(week)
            context.insert(block)
            
            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }
} 