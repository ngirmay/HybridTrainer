import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Weekly Summary Card
                    StatsSummaryCard()
                    
                    // Training Distribution
                    TrainingDistributionCard()
                    
                    // Progress Charts
                    ProgressChartsCard()
                }
                .padding()
            }
            .navigationTitle("Analytics")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
        }
    }
}

struct StatsSummaryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("This Week")
                .font(.system(size: 24, weight: .bold))
            
            HStack(spacing: 24) {
                StatItem(value: "26.2", unit: "mi", label: "Run")
                StatItem(value: "120", unit: "mi", label: "Bike")
                StatItem(value: "4.5", unit: "mi", label: "Swim")
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

struct TrainingDistributionCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Training Distribution")
                .font(.system(size: 20, weight: .bold))
            
            HStack(spacing: 8) {
                ProgressBar(value: 0.4, color: .black)
                ProgressBar(value: 0.35, color: .blue)
                ProgressBar(value: 0.25, color: .gray)
            }
            .frame(height: 160)
            
            HStack(spacing: 16) {
                LegendItem(color: .black, label: "Run")
                LegendItem(color: .blue, label: "Bike")
                LegendItem(color: .gray, label: "Swim")
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

struct ProgressBar: View {
    let value: Double
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: geometry.size.height * value)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct LegendItem: View {
    let color: Color
    let label: String
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct ProgressChartsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Progress Charts")
                .font(.system(size: 20, weight: .bold))
            
            // Placeholder charts
            VStack(spacing: 20) {
                ChartPlaceholder(title: "Weekly Distance")
                ChartPlaceholder(title: "Training Load")
                ChartPlaceholder(title: "Fitness Trend")
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

struct ChartPlaceholder: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .frame(height: 100)
                .overlay(
                    Text("Chart Coming Soon")
                        .foregroundColor(.gray)
                )
        }
    }
} 