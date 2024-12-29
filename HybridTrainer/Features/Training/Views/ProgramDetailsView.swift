import SwiftUI

struct ProgramDetailsView: View {
    let program: TrainingProgram
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                ProgramHeader(program: program)
                
                // Coming Soon Message
                VStack(spacing: 16) {
                    Image(systemName: "hammer.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("Program details coming soon")
                        .font(.headline)
                    Text("We're working hard to bring you detailed workout plans")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProgramHeader: View {
    let program: TrainingProgram
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: program.icon)
                .font(.system(size: 40))
                .frame(width: 80, height: 80)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.top)
            
            Text(program.title)
                .font(.title.bold())
            
            Text(program.description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack(spacing: 24) {
                StatItem(icon: "clock", value: program.sessionDuration, unit: "min")
                StatItem(icon: "calendar", value: program.duration, unit: "")
                StatItem(icon: "chart.bar.fill", value: program.level, unit: "")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(.body, design: .rounded, weight: .semibold))
                if !unit.isEmpty {
                    Text(unit)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
    }
} 