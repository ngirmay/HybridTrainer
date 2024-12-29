import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    // Logo Section
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .padding(.top, 16)
                    
                    // Hero Section
                    VStack(spacing: 8) {
                        Text("Transform Your Training")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("with HybridTrainer")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Combine genetic insights, performance tracking,\nand advanced analytics")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                    }
                    .padding(.horizontal, 24)
                    
                    // Today's Training Card
                    TodayTrainingCard()
                        .padding(.horizontal)
                    
                    // Quick Actions
                    QuickActionsGrid()
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
        }
    }
}

struct FeatureIcon: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack {
            HexagonShape()
                .fill(Color.black)
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                )
            
            Text(title)
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = min(width, height) / 2
        
        let points = (0...5).map { index -> CGPoint in
            let angle = Double(index) * (Double.pi / 3) - Double.pi / 6
            return CGPoint(
                x: center.x + CGFloat(cos(angle)) * radius,
                y: center.y + CGFloat(sin(angle)) * radius
            )
        }
        
        path.move(to: points[0])
        points[1...].forEach { point in
            path.addLine(to: point)
        }
        path.closeSubpath()
        
        return path
    }
}

struct TodayTrainingCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Training")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Swim 2 + Run 8")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("Base Building • Week 4")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Start")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 90, height: 36)
                        .background(Color.black)
                        .cornerRadius(18)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct QuickActionsGrid: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            QuickActionButton(title: "Get Started", icon: "play.fill", isPrimary: true)
            QuickActionButton(title: "Learn More", icon: "book.fill", isPrimary: false)
        }
        .padding(.horizontal)
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let isPrimary: Bool
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(isPrimary ? Color.black : Color.white)
            .foregroundColor(isPrimary ? .white : .black)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.gray.opacity(0.2), lineWidth: isPrimary ? 0 : 1)
            )
            .shadow(color: isPrimary ? Color.black.opacity(0.1) : .clear, radius: 4, x: 0, y: 2)
        }
    }
} 