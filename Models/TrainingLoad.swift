import Foundation

struct TrainingLoad: Identifiable {
    let id = UUID()
    let date: Date
    let ctl: Double
    let atl: Double
    
    var tsb: Double {
        return ctl - atl
    }
} 