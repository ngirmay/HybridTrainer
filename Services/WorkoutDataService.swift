import Foundation
import SwiftData
import Models

class WorkoutDataService {
    private let modelContext: ModelContext
    private let healthKitService: HealthKitService
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.healthKitService = HealthKitService.shared
    }
    
    func fetchWorkouts() async throws -> [Workout] {
        // First try to fetch from HealthKit
        do {
            let workouts = try await healthKitService.fetchWorkouts()
            
            // Save workouts to SwiftData
            for workout in workouts {
                modelContext.insert(workout)
            }
            
            return workouts
        } catch {
            print("Error fetching from HealthKit: \(error)")
            
            // Fallback to local data if HealthKit fails
            let descriptor = FetchDescriptor<Workout>(
                sortBy: [SortDescriptor(\.startDate, order: .reverse)]
            )
            return (try? modelContext.fetch(descriptor)) ?? []
        }
    }
    
    func addWorkout(_ workout: Workout) {
        modelContext.insert(workout)
    }
    
    func deleteWorkout(_ workout: Workout) {
        modelContext.delete(workout)
    }
} 