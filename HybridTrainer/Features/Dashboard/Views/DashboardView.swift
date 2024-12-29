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
                        
                        Text("with HybridTrainer")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.blue)
                        
                        Text("Combine genetic insights, performance tracking, and advanced analytics")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 32)
                    
                    // Feature Icons
                    HStack(spacing: 32) {
                        FeatureIcon(icon: "dna", title: "Genetics")
                        FeatureIcon(icon: "display", title: "Analytics")
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
                .foregroundColor(.secondary)
        }
    }
}

struct TodayTrainingCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Training")
                .font(.headline)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Swim 2 + Run 8")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("Base Building • Week 4")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Start")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 100, height: 40)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct QuickActionsGrid: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            QuickActionButton(title: "Get Started", icon: "play.fill")
            QuickActionButton(title: "Learn More", icon: "book.fill")
        }
        .padding(.horizontal)
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(title == "Get Started" ? Color.black : Color.white)
            .foregroundColor(title == "Get Started" ? .white : .black)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray.opacity(0.2), lineWidth: title == "Get Started" ? 0 : 1)
            )
        }
    }
} 