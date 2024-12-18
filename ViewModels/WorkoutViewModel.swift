import SwiftUI
import Models
import SwiftData

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published private(set) var workouts: [Workout] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let workoutService: WorkoutDataService
    
    init(modelContext: ModelContext) {
        self.workoutService = WorkoutDataService(modelContext: modelContext)
    }
    
    func loadWorkouts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            workouts = try await workoutService.fetchWorkouts()
        } catch {
            self.error = error
        }
    }
} 