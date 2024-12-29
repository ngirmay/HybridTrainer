import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Section
                    VStack(spacing: 16) {
                        Text("Transform Your Training")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("with HybridTrainer")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Combine genetic insights, performance tracking, and advanced analytics")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 32)
                    
                    // Feature Icons
                    HStack(spacing: 32) {
                        FeatureIcon(icon: "figure.run", title: "Training")
                        FeatureIcon(icon: "chart.bar", title: "Analytics")
                        FeatureIcon(icon: "chart.line.uptrend.xyaxis", title: "Progress")
                    }
                    .padding()
                    
                    // Today's Training
                    TodayTrainingCard()
                    
                    // Quick Actions
                    QuickActionsGrid()
                }
            }
            .navigationTitle("Dashboard")
            .background(Color.white)
        }
    }
}

struct FeatureIcon: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack {
            Circle()
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

struct TodayTrainingCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Training")
                .font(.headline)
                .foregroundColor(.black)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Swim 2 + Run 8")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Base Building • Week 4")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Start")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40)
                        .background(Color.black)
                        .cornerRadius(20)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
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
            HStack {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isPrimary ? Color.black : Color.white)
            .foregroundColor(isPrimary ? .white : .black)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray.opacity(0.2), lineWidth: isPrimary ? 0 : 1)
            )
        }
    }
} 