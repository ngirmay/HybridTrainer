import Foundation
import BackgroundTasks
import Reachability

class SyncService {
    static let shared = SyncService()
    private var reachability: Reachability?
    
    init() {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to start Reachability: \(error)")
        }
    }
    
    func startMonitoring() {
        reachability?.whenReachable = { _ in
            Task {
                await self.syncPendingData()
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start Reachability notifier: \(error)")
        }
    }
    
    private func syncPendingData() async {
        do {
            let unsyncedWorkouts = try CacheService.shared.getUnsyncedWorkouts()
            try await APIService.shared.syncWorkouts(unsyncedWorkouts)
            try CacheService.shared.markAsSynced(workouts: unsyncedWorkouts)
        } catch {
            print("Failed to sync pending data: \(error)")
        }
    }
    
    func handleWorkoutCompletion(_ workout: HKWorkout) async {
        do {
            let workoutData = WorkoutData(from: workout)
            try CacheService.shared.cacheWorkouts([workoutData])
            
            if reachability?.connection != .unavailable {
                try await APIService.shared.syncWorkouts([workout])
                try CacheService.shared.markAsSynced(workouts: [workoutData])
            }
        } catch {
            print("Failed to handle workout completion: \(error)")
        }
    }
    
    func syncHealthData(_ healthData: DailyHealthData) async throws {
        // Convert to API format
        let data = try JSONEncoder().encode(healthData)
        
        // Send to API
        try await APIService.shared.post(
            endpoint: "workouts/sync",
            body: data
        )
    }
} 