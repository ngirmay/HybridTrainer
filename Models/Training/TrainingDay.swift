import SwiftData
import Foundation

@Model
public final class TrainingDay {
    @Attribute(.unique) public var id: UUID
    public var date: Date
    @Relationship(deleteRule: .cascade) public var workouts: [PlannedWorkout]
    public var notes: String?
    
    public init(
        id: UUID = UUID(),
        date: Date,
        workouts: [PlannedWorkout] = [],
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.workouts = workouts
        self.notes = notes
    }
} 