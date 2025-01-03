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
                id: cached.id ?? "",
                type: cached.type ?? "",
                startDate: cached.startDate ?? Date(),
                endDate: cached.endDate ?? Date(),
                duration: cached.duration,
                distance: cached.distance,
                energyBurned: nil,
                heartRate: nil
            )
        }
    }
    
    func markAsSynced(workoutId: String) throws {
        let context = container.viewContext
        let request: NSFetchRequest<CachedWorkout> = CachedWorkout.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", workoutId)
        
        if let workout = try context.fetch(request).first {
            workout.synced = true
            try context.save()
        }
    }
    
    func markAllAsSynced(workoutIds: [String]) throws {
        let context = container.viewContext
        let request: NSFetchRequest<CachedWorkout> = CachedWorkout.fetchRequest()
        request.predicate = NSPredicate(format: "id IN %@", workoutIds)
        
        let workouts = try context.fetch(request)
        workouts.forEach { $0.synced = true }
        
        try context.save()
    }
} 