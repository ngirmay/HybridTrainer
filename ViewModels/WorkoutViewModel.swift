import SwiftUI
import Models

@MainActor
class WorkoutViewModel: ObservableObject {
    @Published private(set) var workouts: [DetailedWorkout] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let workoutService: WorkoutDataServiceProtocol
    
    init(workoutService: WorkoutDataServiceProtocol) {
        self.workoutService = workoutService
    }
    
    func loadWorkouts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            workouts = try await workoutService.fetchWorkouts(from: nil)
        } catch {
            self.error = error
        }
    }
} 