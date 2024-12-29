import SwiftData
import Foundation

@Model
public final class TrainingWeek {
    @Attribute(.unique) public var id: UUID
    public var blockId: UUID
    public var weekNumber: Int
    public var startDate: Date
    
    @Relationship(deleteRule: .cascade) public var sessions: [TrainingDay]
    @Relationship public var metrics: WeeklyMetrics?
    
    public init(
        id: UUID = UUID(),
        blockId: UUID,
        weekNumber: Int,
        startDate: Date,
        sessions: [TrainingDay] = [],
        metrics: WeeklyMetrics? = nil
    ) {
        self.id = id
        self.blockId = blockId
        self.weekNumber = weekNumber
        self.startDate = startDate
        self.sessions = sessions
        self.metrics = metrics
    }
} 