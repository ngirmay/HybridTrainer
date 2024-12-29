import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<4) { index in
                Button(action: { selectedTab = index }) {
                    VStack(spacing: 4) {
                        Image(systemName: iconName(for: index))
                            .font(.system(size: 20))
                        Text(title(for: index))
                            .font(.system(size: 12))
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundColor(selectedTab == index ? .black : .gray)
            }
        }
        .padding(.vertical, 8)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.2)),
            alignment: .top
        )
    }
    
    private func iconName(for index: Int) -> String {
        switch index {
        case 0: return "chart.bar.fill"
        case 1: return "figure.run"
        case 2: return "chart.line.uptrend.xyaxis"
        case 3: return "person.fill"
        default: return ""
        }
    }
    
    private func title(for index: Int) -> String {
        switch index {
        case 0: return "Dashboard"
        case 1: return "Training"
        case 2: return "Analytics"
        case 3: return "Profile"
        default: return ""
        }
    }
} 