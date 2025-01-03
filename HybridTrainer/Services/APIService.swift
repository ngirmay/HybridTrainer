import Foundation
import HealthKit

public class APIService {
    public static let shared = APIService()
    
    private let baseURL = URL(string: "https://api.hybridtrainer.app/v1")!
    private let session = URLSession.shared
    
    public func get(endpoint: String) async throws -> Any {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        request.httpMethod = "GET"
        addAuthHeader(to: &request)
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        return try JSONSerialization.jsonObject(with: data)
    }
    
    public func post(endpoint: String, body: [String: Any]) async throws -> [String: Any] {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        addAuthHeader(to: &request)
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        
        return try JSONSerialization.jsonObject(with: data) as! [String: Any]
    }
    
    private func addAuthHeader(to request: inout URLRequest) {
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(httpResponse.statusCode)
        }
    }
}

public enum APIError: Error {
    case invalidResponse
    case httpError(Int)
    case decodingError
    case encodingError
}

// MARK: - API Response Types
public struct ProgramsResponse: Codable {
    public let programs: [TrainingProgram]
    public let total: Int
} 