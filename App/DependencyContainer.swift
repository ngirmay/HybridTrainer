import SwiftData
import Foundation

public final class DependencyContainer {
    // Core dependencies
    public let modelContext: ModelContext
    
    // Services
    public let healthKitManager: HealthKitManaging
    public let trainingService: TrainingPlanManaging
    public let analyticsService: AnalyticsServicing
    
    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.healthKitManager = HealthKitManager()
        self.trainingService = TrainingPlanService(modelContext: modelContext)
        self.analyticsService = AnalyticsService()
    }
} 