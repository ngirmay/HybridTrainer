import SwiftUI

struct ProgramDetailsView: View {
    let program: TrainingProgram
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(program.title)
                    .font(.title)
                    .bold()
                
                Text(program.description)
                    .foregroundColor(.gray)
                
                HStack(spacing: 24) {
                    StatItem(icon: "clock", value: program.sessionDuration, unit: "min")
                    StatItem(icon: "calendar", value: program.duration, unit: "")
                    StatItem(icon: "chart.bar.fill", value: program.level, unit: "")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ProgramDetailsView(program: samplePrograms[0])
    }
} 