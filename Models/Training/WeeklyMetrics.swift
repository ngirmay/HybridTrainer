import SwiftData
import Foundation

@Model
public final class WeeklyMetrics {
    @Attribute(.unique) public var id: UUID
    public var runMileage: Double?
    public var bikeMileage: Double?
    public var swimMileage: Double?
    public var isClean: Bool
    
    @Relationship(inverse: \TrainingWeek.metrics)
    public var week: TrainingWeek?
    
    public init(
        id: UUID = UUID(),
        runMileage: Double? = nil,
        bikeMileage: Double? = nil,
        swimMileage: Double? = nil,
        isClean: Bool = true
    ) {
        self.id = id
        self.runMileage = runMileage
        self.bikeMileage = bikeMileage
        self.swimMileage = swimMileage
        self.isClean = isClean
    }
} 