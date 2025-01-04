import SwiftUI

struct SplitsView: View {
    let splits: [Split]
    @State private var selectedSplit: Split?
    @State private var showingDetails = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(splits) { split in
                Button(action: { 
                    selectedSplit = split
                    showingDetails = true
                }) {
                    HStack {
                        Text("Mile \(split.distance, specifier: "%.1f")")
                            .font(.subheadline)
                            .foregroundColor(Theme.textSecondary)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(formatPace(split.pace))
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(Theme.text)
                            
                            Text(formatTime(split.duration))
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .padding(.vertical, 12)
                }
                
                if split.id != splits.last?.id {
                    Divider()
                }
            }
        }
        .sheet(item: $selectedSplit) { split in
            SplitDetailView(split: split)
        }
    }
    
    private func formatPace(_ pace: Double) -> String {
        let minutes = Int(pace)
        let seconds = Int((pace - Double(minutes)) * 60)
        return String(format: "%d:%02d /mi", minutes, seconds)
    }
    
    private func formatTime(_ duration: Double) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d:%02d", hours, minutes, seconds)
    }
}

struct SplitDetailView: View {
    let split: Split
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Split Details")
                .font(.title)
            
            VStack(alignment: .leading, spacing: 8) {
                DetailRow(label: "Distance", value: "\(split.distance, specifier: "%.2f") mi")
                DetailRow(label: "Duration", value: formatTime(split.duration))
                DetailRow(label: "Pace", value: formatPace(split.pace))
            }
            .padding()
        }
    }
    
    private func formatTime(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func formatPace(_ pace: Double) -> String {
        let minutes = Int(pace)
        let seconds = Int((pace - Double(minutes)) * 60)
        return String(format: "%d:%02d /mi", minutes, seconds)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    SplitsView(splits: WorkoutDetails.sampleData.splits)
} 