@Observable
public final class GoalsViewModel {
    private let modelContext: ModelContext
    private let trainingService: TrainingPlanManaging
    
    public init(
        modelContext: ModelContext,
        trainingService: TrainingPlanManaging
    ) {
        self.modelContext = modelContext
        self.trainingService = trainingService
    }
    
    // Implementation...
} 