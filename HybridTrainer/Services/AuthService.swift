import Foundation

public class AuthService {
    public static let shared = AuthService()
    private let userDefaults = UserDefaults.standard
    
    private var currentProfile: UserProfile?
    
    public var isAuthenticated: Bool {
        userDefaults.string(forKey: "authToken") != nil
    }
    
    public func signIn(email: String, password: String) async throws -> UserProfile {
        let response = try await APIService.shared.post(
            endpoint: "auth/signin",
            body: ["email": email, "password": password]
        )
        
        if let token = response["token"] as? String {
            userDefaults.set(token, forKey: "authToken")
            let profile = try JSONDecoder().decode(UserProfile.self, from: response["user"] as! Data)
            currentProfile = profile
            return profile
        }
        
        throw AuthError.invalidCredentials
    }
    
    public func signOut() {
        userDefaults.removeObject(forKey: "authToken")
        currentProfile = nil
    }
    
    public func getCurrentProfile() async throws -> UserProfile {
        if let profile = currentProfile {
            return profile
        }
        
        let response = try await APIService.shared.get(endpoint: "auth/profile")
        let profile = try JSONDecoder().decode(UserProfile.self, from: response as! Data)
        currentProfile = profile
        return profile
    }
}

public enum AuthError: Error {
    case invalidCredentials
    case notAuthenticated
    case networkError
} 