/// Service responsible for managing training plans
///
/// The training plan service handles:
/// - Creating new training blocks
/// - Updating existing plans
/// - Managing training phases
/// - Coordinating with HealthKit for workout data
public protocol TrainingPlanManaging {
    /// Creates a new training plan
    /// - Parameters:
    ///   - phase: The training phase to start with
    ///   - startDate: When the plan should begin
    /// - Returns: A new training block
    func createPlan(phase: TrainingPhase, startDate: Date) async throws -> TrainingBlock
    func updatePlan(_ plan: TrainingBlock) async throws
    func deletePlan(_ plan: TrainingBlock) async throws
}

public final class TrainingPlanService: TrainingPlanManaging {
    private let modelContext: ModelContext
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // Implementation...
} 