import SwiftUI

enum Theme {
    static let primaryColor = Color(hex: "4A6670") // The blue-gray from your contact button
    static let backgroundColor = Color(hex: "F5F5F5") // Light gray background
    static let textColor = Color(hex: "2C3E50") // Dark gray text
    
    static let cardBackground = Color.white
    static let secondaryText = Color.gray.opacity(0.8)
    
    static let padding = EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    static let cornerRadius: CGFloat = 16
    
    static let shadowColor = Color.black.opacity(0.05)
    static let shadowRadius: CGFloat = 15
    static let shadowY: CGFloat = 5
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
} 