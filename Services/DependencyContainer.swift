import Foundation
import SwiftData

class DependencyContainer {
    static let shared = DependencyContainer()
    
    let modelContainer: ModelContainer
    
    private init() {
        do {
            let schema = Schema([
                TrainingSession.self,
                PlannedWorkout.self,
                TrainingBlock.self,
                TrainingWeek.self,
                TrainingDay.self,
                WeeklyMetrics.self,
                Goal.self,
                Workout.self,
                WeeklyVolume.self
            ])
            
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )
            
            modelContainer = try ModelContainer(
                for: schema,
                configurations: modelConfiguration
            )
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
} 