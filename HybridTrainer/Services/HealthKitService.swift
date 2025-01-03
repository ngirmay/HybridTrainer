import HealthKit
import CoreLocation
import Foundation

public struct DailyHealthData {
    let date: Date
    let stepCount: Int
    let heartRateSamples: [HeartRateSample]
    let averageHeartRate: Double
}

public struct HeartRateSample {
    let timestamp: Date
    let value: Double
}

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
        
        let averageHeartRate = heartRateSamples.isEmpty ? 0 : 
            heartRateSamples.map(\.value).reduce(0, +) / Double(heartRateSamples.count)
        
        return DailyHealthData(
            date: date,
            stepCount: stepCount,
            heartRateSamples: heartRateSamples,
            averageHeartRate: averageHeartRate
        )
    }
    
    private func fetchHeartRateSamples(start: Date, end: Date) async throws -> [HeartRateSample] {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            throw HealthKitError.notAvailable
        }
        
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: end,
            options: .strictStartDate
        )
        
        let samples = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[HKQuantitySample], Error>) in
            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                let quantitySamples = samples as? [HKQuantitySample] ?? []
                continuation.resume(returning: quantitySamples)
            }
            
            healthStore.execute(query)
        }
        
        return samples.map { sample in
            HeartRateSample(
                timestamp: sample.startDate,
                value: sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
            )
        }
    }
    
    private func fetchStepCount(start: Date, end: Date) async throws -> Int {
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            throw HealthKitError.notAvailable
        }
        
        let predicate = HKQuery.predicateForSamples(
            withStart: start,
            end: end,
            options: .strictStartDate
        )
        
        let statistics = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<HKStatistics, Error>) in
            let query = HKStatisticsQuery(
                quantityType: stepCountType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum
            ) { _, statistics, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let statistics = statistics else {
                    continuation.resume(throwing: HealthKitError.failedToFetch)
                    return
                }
                
                continuation.resume(returning: statistics)
            }
            
            healthStore.execute(query)
        }
        
        return Int(statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0)
    }
}

enum HealthKitError: Error {
    case notAvailable
    case notAuthorized
    case failedToFetch
} 