struct PhaseProgressView: View {
    let phase: TrainingPhase
    
    var phaseColor: Color {
        switch phase {
        case .base: return .blue
        case .build: return .green
        case .speed: return .orange
        case .taper: return .purple
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(phase.rawValue.capitalized)
                    .font(.headline)
                Spacer()
                Image(systemName: "flame.fill")
                    .foregroundStyle(phaseColor)
            }
            
            // Phase progress indicator
            ProgressView(value: 0.6) // We'll make this dynamic later
                .tint(phaseColor)
        }
        .padding()
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.Metrics.cornerRadius)
    }
} 