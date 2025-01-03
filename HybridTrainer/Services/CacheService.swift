import Foundation
import CoreData

class CacheService {
    static let shared = CacheService()
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "HybridTrainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func cacheWorkouts(_ workouts: [WorkoutData]) throws {
        let context = container.viewContext
        
        for workout in workouts {
            let cachedWorkout = CachedWorkout(context: context)
            cachedWorkout.id = workout.id
            cachedWorkout.type = workout.type
            cachedWorkout.startDate = workout.startDate
            cachedWorkout.endDate = workout.endDate
            cachedWorkout.duration = workout.duration
            cachedWorkout.distance = workout.distance ?? 0
            cachedWorkout.synced = false
        }
        
        try context.save()
    }
    
    func getUnsyncedWorkouts() throws -> [WorkoutData] {
        let context = container.viewContext
        let request: NSFetchRequest<CachedWorkout> = CachedWorkout.fetchRequest()
        request.predicate = NSPredicate(format: "synced == NO")
        
        let cachedWorkouts = try context.fetch(request)
        return cachedWorkouts.map { cached in
            WorkoutData(
                id: cached.id,
                type: cached.type,
                startDate: cached.startDate,
                endDate: cached.endDate,
                duration: cached.duration,
                distance: cached.distance,
                energyBurned: nil,
                heartRate: nil
            )
        }
    }
} 