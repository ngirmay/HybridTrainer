import SwiftData
import Foundation

@Model
public final class TrainingBlock {
    @Attribute(.unique) public var id: UUID
    public var phase: TrainingPhase
    public var startDate: Date
    public var endDate: Date
    public var focus: String
    
    @Relationship(deleteRule: .cascade) public var weeks: [TrainingWeek]
    
    public init(
        id: UUID = UUID(),
        phase: TrainingPhase,
        startDate: Date,
        endDate: Date,
        focus: String,
        weeks: [TrainingWeek] = []
    ) {
        self.id = id
        self.phase = phase
        self.startDate = startDate
        self.endDate = endDate
        self.focus = focus
        self.weeks = weeks
    }
} 