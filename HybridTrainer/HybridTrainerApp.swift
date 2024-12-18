import SwiftUI
import SwiftData
import Models
import HealthKit

@main
struct HybridTrainerApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Goal.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
} 