import Foundation
import Network

class SyncService {
    static let shared = SyncService()
    private let monitor = NWPathMonitor()
    private var isConnected: Bool = false
    
    init() {
        setupNetworkMonitoring()
    }
    
    private func setupNetworkMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            if path.status == .satisfied {
                Task {
                    await self?.syncPendingData()
                }
            }
        }
        monitor.start(queue: DispatchQueue.global())
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
    
    func syncHealthData(_ healthData: DailyHealthData) async throws {
        guard isConnected else {
            // Cache for later sync if offline
            try CacheService.shared.cacheHealthData(healthData)
            return
        }
        
        let data = try JSONEncoder().encode(healthData)
        try await APIService.shared.post(endpoint: "workouts/sync", body: data)
    }
} 