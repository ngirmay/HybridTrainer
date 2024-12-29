import Foundation

struct UserProfile: Codable {
    var id: UUID
    var name: String
    var email: String
    var preferences: UserPreferences
    
    struct UserPreferences: Codable {
        var preferredUnits: UnitSystem
        var weeklyGoals: WeeklyGoals
    }
    
    enum UnitSystem: String, Codable {
        case metric
        case imperial
    }
    
    struct WeeklyGoals: Codable {
        var swimmingDistance: Double  // In meters
        var cyclingDistance: Double   // In meters
        var runningDistance: Double   // In meters
        var strengthSessions: Int
    }
} 