import SwiftUI

enum Theme {
    enum Colors {
        // Base colors from your website
        static let background = Color(hex: "#FFFFFF")
        static let primary = Color(hex: "#1A1A1A")
        static let secondary = Color(hex: "#6B7280")
        static let accent = Color(hex: "#4A6670") // Your website's blue-gray
        
        // Workout type colors
        static let swim = Color(hex: "#0EA5E9")    // Blue
        static let bike = Color(hex: "#22C55E")    // Green
        static let run = Color(hex: "#F97316")     // Orange
        static let strength = Color(hex: "#A855F7") // Purple
        
        // Semantic colors
        static let success = Color(hex: "#22C55E")
        static let warning = Color(hex: "#F97316")
        static let error = Color(hex: "#EF4444")
        
        // Surface colors
        static let cardBackground = Color(hex: "#FFFFFF")
        static let surfaceSecondary = Color(hex: "#F3F4F6")
    }
    
    enum Typography {
        static let largeTitle = Font.system(size: 34, weight: .bold)
        static let title1 = Font.system(size: 28, weight: .bold)
        static let title2 = Font.system(size: 22, weight: .semibold)
        static let title3 = Font.system(size: 20, weight: .semibold)
        static let headline = Font.system(size: 17, weight: .semibold)
        static let body = Font.system(size: 17, weight: .regular)
        static let callout = Font.system(size: 16, weight: .regular)
        static let subheadline = Font.system(size: 15, weight: .regular)
        static let footnote = Font.system(size: 13, weight: .regular)
        static let caption = Font.system(size: 12, weight: .regular)
    }
    
    enum Metrics {
        static let spacing: CGFloat = 8
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        
        enum Icons {
            static let small: CGFloat = 24
            static let medium: CGFloat = 32
            static let large: CGFloat = 40
        }
    }
    
    enum Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let quick = SwiftUI.Animation.easeInOut(duration: 0.15)
    }
}

// View modifiers for consistent styling
extension View {
    func cardStyle() -> some View {
        self
            .padding(Theme.Metrics.padding)
            .background(Theme.Colors.cardBackground)
            .cornerRadius(Theme.Metrics.cornerRadius)
            .shadow(color: Theme.Colors.primary.opacity(0.05), radius: 8, x: 0, y: 2)
    }
    
    func primaryButtonStyle() -> some View {
        self
            .padding(.horizontal, Theme.Metrics.padding)
            .padding(.vertical, Theme.Metrics.padding / 2)
            .background(Theme.Colors.accent)
            .foregroundColor(.white)
            .cornerRadius(Theme.Metrics.cornerRadius)
    }
} 