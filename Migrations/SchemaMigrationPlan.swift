import Foundation
import SwiftData

enum SchemaVersion: String, Comparable {
    case v1_0_0 // Initial version
    case v1_1_0 // Added training blocks
    case v1_2_0 // Current version
    
    static func <(lhs: SchemaVersion, rhs: SchemaVersion) -> Bool {
        switch (lhs, rhs) {
        case (.v1_0_0, .v1_1_0), (.v1_0_0, .v1_2_0), (.v1_1_0, .v1_2_0):
            return true
        default:
            return false
        }
    }
}

struct SchemaMigrationPlan {
    static let current = Self.v1_2_0
    
    static var v1_2_0: Schema {
        Schema(version: SchemaVersion.v1_2_0.rawValue) {
            TrainingSession.self
            PlannedWorkout.self
            TrainingBlock.self
            TrainingWeek.self
            TrainingDay.self
            WeeklyMetrics.self
        }
    }
    
    static func performMigration(from oldVersion: SchemaVersion) async throws {
        switch oldVersion {
        case .v1_0_0:
            try await migrateV1_0_0ToV1_1_0()
            try await migrateV1_1_0ToV1_2_0()
        case .v1_1_0:
            try await migrateV1_1_0ToV1_2_0()
        case .v1_2_0:
            break // Already at current version
        }
    }
    
    private static func migrateV1_0_0ToV1_1_0() async throws {
        // Migration logic here
    }
    
    private static func migrateV1_1_0ToV1_2_0() async throws {
        // Migration logic here
    }
} 