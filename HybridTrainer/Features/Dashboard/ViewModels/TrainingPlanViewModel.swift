@MainActor
class TrainingPlanViewModel: ObservableObject {
    @Published private(set) var currentWeek: TrainingWeek?
    @Published private(set) var currentPhase: TrainingPhase = .base
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let modelContext: ModelContext
    private let planService: TrainingPlanService
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.planService = TrainingPlanService(modelContext: modelContext)
    }
    
    func loadPlan(_ planId: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await planService.createPlan(planId)
            // After creating plan, update current week and phase
            updateCurrentWeek()
        } catch {
            self.error = error
        }
    }
    
    private func updateCurrentWeek() {
        // Implementation will come in next phase
    }
} 