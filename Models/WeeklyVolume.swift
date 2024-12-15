import Foundation
import SwiftData

@Model
public final class WeeklyVolume {
    @Attribute(.unique) public var id: UUID
    public var week: Date
    public var swimHours: Double
    public var bikeHours: Double
    public var runHours: Double
    public var totalTSS: Double
    
    public init(week: Date, swimHours: Double = 0, bikeHours: Double = 0, runHours: Double = 0, totalTSS: Double = 0) {
        self.id = UUID()
        self.week = week
        self.swimHours = swimHours
        self.bikeHours = bikeHours
        self.runHours = runHours
        self.totalTSS = totalTSS
    }
} 