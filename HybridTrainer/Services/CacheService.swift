import CoreData

class CacheService {
    static let shared = CacheService()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "HybridTrainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    // Cache workouts locally
    func cacheWorkouts(_ workouts: [WorkoutData]) throws {
        let context = container.viewContext
        
        for workout in workouts {
            let cachedWorkout = CachedWorkout(context: context)
            cachedWorkout.id = workout.id
            cachedWorkout.type = workout.type
            cachedWorkout.startDate = ISO8601DateFormatter().date(from: workout.startDate)
            cachedWorkout.endDate = ISO8601DateFormatter().date(from: workout.endDate)
            cachedWorkout.duration = workout.duration
            cachedWorkout.distance = workout.distance ?? 0
            cachedWorkout.synced = false
        }
        
        try context.save()
    }
    
    // Get unsynced workouts
    func getUnsyncedWorkouts() throws -> [WorkoutData] {
        let context = container.viewContext
        let request: NSFetchRequest<CachedWorkout> = CachedWorkout.fetchRequest()
        request.predicate = NSPredicate(format: "synced == NO")
        
        let cachedWorkouts = try context.fetch(request)
        return cachedWorkouts.map { cached in
            WorkoutData(
                id: cached.id ?? "",
                type: cached.type ?? "",
                startDate: cached.startDate?.ISO8601Format() ?? "",
                endDate: cached.endDate?.ISO8601Format() ?? "",
                duration: cached.duration,
                distance: cached.distance,
                energyBurned: cached.energyBurned,
                userId: cached.userId ?? ""
            )
        }
    }
} 