import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)
}

class APIService {
    static let shared = APIService()
    private let baseURL = "https://your-domain.com/api" // Update with your domain
    
    func fetchPrograms() async throws -> [TrainingProgram] {
        guard let url = URL(string: "\(baseURL)/programs") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(ProgramsResponse.self, from: data)
            return result.programs
        } catch {
            throw APIError.decodingError
        }
    }
    
    func syncWorkouts(_ workouts: [HKWorkout]) async throws {
        guard let url = URL(string: "\(baseURL)/workouts/sync") else {
            throw APIError.invalidURL
        }
        
        let workoutData = workouts.map { workout in
            return WorkoutData(
                id: workout.uuid.uuidString,
                type: workout.workoutActivityType.name,
                startDate: workout.startDate.ISO8601Format(),
                endDate: workout.endDate.ISO8601Format(),
                duration: workout.duration,
                distance: workout.totalDistance?.doubleValue(for: .meter()),
                energyBurned: workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()),
                userId: AuthService.shared.getCurrentUser()?.id ?? ""
            )
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(workoutData)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
    }
}

struct ProgramsResponse: Codable {
    let programs: [TrainingProgram]
} 