import SwiftUI

enum Theme {
    enum Colors {
        static let background = Color("Background")
        static let primary = Color("Primary")
        static let secondary = Color("Secondary")
        static let accent = Color("Accent")
        
        // Add your website's specific hex colors here using Color+Hex extension
        static let cardBackground = Color(hex: "#FFFFFF")
        static let textPrimary = Color(hex: "#1A1A1A")
        static let textSecondary = Color(hex: "#6B7280")
    }
    
    enum Metrics {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
    }
} 