import XCTest
@testable import HybridTrainer

final class TrainingPlanServiceTests: XCTestCase {
    var sut: TrainingPlanService!
    var mockModelContext: MockModelContext!
    
    override func setUp() {
        super.setUp()
        mockModelContext = MockModelContext()
        sut = TrainingPlanService(modelContext: mockModelContext)
    }
    
    func testCreatePlan() async throws {
        // Given
        let phase = TrainingPhase.base
        let startDate = Date()
        
        // When
        let plan = try await sut.createPlan(phase: phase, startDate: startDate)
        
        // Then
        XCTAssertEqual(plan.phase, phase)
        XCTAssertEqual(plan.startDate, startDate)
    }
} 