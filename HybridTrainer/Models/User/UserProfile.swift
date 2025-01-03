import Foundation

public struct UserProfile: Codable {
    public let id: String
    public let email: String
    public let name: String?
    public let avatarUrl: String?
    public let preferences: UserPreferences
    
    public init(id: String, email: String, name: String? = nil, avatarUrl: String? = nil, preferences: UserPreferences = .default) {
        self.id = id
        self.email = email
        self.name = name
        self.avatarUrl = avatarUrl
        self.preferences = preferences
    }
}

public struct UserPreferences: Codable {
    public var distanceUnit: DistanceUnit
    public var weightUnit: WeightUnit
    
    public static let `default` = UserPreferences(distanceUnit: .miles, weightUnit: .pounds)
    
    public init(distanceUnit: DistanceUnit, weightUnit: WeightUnit) {
        self.distanceUnit = distanceUnit
        self.weightUnit = weightUnit
    }
}

public enum DistanceUnit: String, Codable {
    case miles
    case kilometers
}

public enum WeightUnit: String, Codable {
    case pounds
    case kilograms
} 