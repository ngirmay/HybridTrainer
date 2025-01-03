import HealthKit
import CoreLocation

class HealthKitService {
    static let shared = HealthKitService()
    private let healthStore = HKHealthStore()
    
    private let typesToRead: Set<HKObjectType> = [
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
    ]
    
    func requestAuthorization() async throws {
        try await healthStore.requestAuthorization(toShare: [], read: typesToRead)
    }
    
    func fetchDailyHealthData(for date: Date) async throws -> DailyHealthData {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let heartRateSamples = try await fetchHeartRateSamples(start: startOfDay, end: endOfDay)
        let stepCount = try await fetchStepCount(start: startOfDay, end: endOfDay)
        
        return DailyHealthData(
            date: date,
            stepCount: stepCount,
            heartRateSamples: heartRateSamples,
            averageHeartRate: heartRateSamples.map(\.value).reduce(0, +) / Double(heartRateSamples.count)
        )
    }
    
    private func fetchHeartRateSamples(start: Date, end: Date) async throws -> [HeartRateSample] {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            throw HealthKitError.notAvailable
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(predicate)],
            sortDescriptors: [SortDescriptor(\.startDate, order: .forward)]
        )
        
        let samples = try await descriptor.result(for: healthStore)
        return samples.map { sample in
            HeartRateSample(
                timestamp: sample.startDate,
                value: sample.quantity.doubleValue(for: .count().unitDivided(by: .minute()))
            )
        }
    }
    
    private func fetchStepCount(start: Date, end: Date) async throws -> Int {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            throw HealthKitError.notAvailable
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: predicate,
            options: .cumulativeSum
        )
        
        let statistics = try await descriptor.result(for: healthStore)
        return Int(statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0)
    }
}

enum HealthKitError: Error {
    case notAvailable
    case notAuthorized
    case failedToFetch
} 