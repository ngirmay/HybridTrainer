import SwiftUI

enum Theme {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let accent = Color("Accent")
    static let background = Color("Background")
    static let cardBackground = Color("CardBackground")
    static let text = Color("TextColor")
    static let textSecondary = Color("TextSecondary")
    
    static let heartRateGradient = LinearGradient(
        colors: [.red.opacity(0.8), .red],
        startPoint: .bottom,
        endPoint: .top
    )
    
    static let cardShadow = Color.black.opacity(0.1)
} 