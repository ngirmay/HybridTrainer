import SwiftUI

struct SplitsView: View {
    let splits: [Split]
    @State private var selectedSplit: Split?
    @State private var showingDetails = false
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(splits.indices, id: \.self) { index in
                Button(action: { 
                    selectedSplit = splits[index]
                    showingDetails = true
                }) {
                    HStack {
                        Text("Mile \(index + 1)")
                            .font(.subheadline)
                            .foregroundColor(Theme.textSecondary)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(formatPace(splits[index].pace))
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(Theme.text)
                            
                            Text(formatTime(splits[index].duration))
                                .font(.caption)
                                .foregroundColor(Theme.textSecondary)
                        }
                    }
                    .padding(.vertical, 12)
                }
                
                if index < splits.count - 1 {
                    Divider()
                }
            }
        }
        .sheet(isPresented: $showingDetails) {
            if let split = selectedSplit {
                SplitDetailView(split: split)
            }
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