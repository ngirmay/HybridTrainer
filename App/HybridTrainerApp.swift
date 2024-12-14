import SwiftUI
import SwiftData

@main
struct HybridTrainerApp: App {
    init() {
        Task {
            do {
                try await HealthKitService.shared.requestAuthorization()
            } catch {
                print("HealthKit authorization failed: \(error)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Goal.self, Workout.self])
    }
} 
