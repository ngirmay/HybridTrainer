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