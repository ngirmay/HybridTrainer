@MainActor
class TrainingPlanViewModel: ObservableObject {
    @Published private(set) var currentWeek: TrainingWeek?
    @Published private(set) var currentPhase: TrainingPhase = .base
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let planService = TrainingPlanService.shared
    private var metadata: TrainingPlanService.PlanMetadata?
    private var weeks: [TrainingWeek] = []
    
    func loadPlan(_ planId: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let (metadata, weeks) = try await planService.loadPlan(planId)
            self.metadata = metadata
            self.weeks = weeks
            
            updateCurrentWeek()
            updateCurrentPhase()
        } catch {
            self.error = error
        }
    }
    
    private func updateCurrentWeek() {
        let today = Date()
        currentWeek = weeks.first { week in
            let weekInterval = DateInterval(
                start: week.startDate,
                duration: 7 * 24 * 3600
            )
            return weekInterval.contains(today)
        }
    }
    
    private func updateCurrentPhase() {
        guard let metadata = metadata else { return }
        
        let today = Date()
        for (phase, interval) in metadata.phases {
            if interval.contains(today) {
                currentPhase = phase
                break
            }
        }
    }
} 