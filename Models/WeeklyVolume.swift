import Foundation
import SwiftData

@Model
final class WeeklyVolume {
    @Attribute(.unique) var id: UUID
    var week: Date
    var swimHours: Double
    var bikeHours: Double
    var runHours: Double
    var totalTSS: Double
    
    init(week: Date, swimHours: Double = 0, bikeHours: Double = 0, runHours: Double = 0, totalTSS: Double = 0) {
        self.id = UUID()
        self.week = week
        self.swimHours = swimHours
        self.bikeHours = bikeHours
        self.runHours = runHours
        self.totalTSS = totalTSS
    }
} 