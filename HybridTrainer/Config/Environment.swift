enum Environment {
    static let apiBaseURL: String = {
        #if DEBUG
        return "http://localhost:3000/api"
        #else
        return "https://your-production-domain.com/api"
        #endif
    }()
} 