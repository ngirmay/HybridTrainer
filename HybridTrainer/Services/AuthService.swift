import Foundation

class AuthService {
    static let shared = AuthService()
    
    func signIn(email: String, password: String) async throws -> UserProfile {
        // Implement sign in logic
        // This would connect to your chosen auth provider
        // (Firebase, Auth0, custom, etc.)
    }
    
    func signOut() async throws {
        // Implement sign out logic
    }
    
    func getCurrentUser() -> UserProfile? {
        // Return cached user if available
    }
} 