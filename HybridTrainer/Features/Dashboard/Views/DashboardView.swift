import SwiftUI
import Charts

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Today's Activity") {
                    // Step Count Card
                    HStack {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 24))
                        VStack(alignment: .leading) {
                            Text("Steps")
                                .font(.subheadline)
                            Text("\(viewModel.stepCount)")
                                .font(.title2)
                                .bold()
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // Heart Rate Chart
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Heart Rate")
                            .font(.subheadline)
                        
                        if !viewModel.heartRateSamples.isEmpty {
                            Chart {
                                ForEach(viewModel.heartRateSamples, id: \.timestamp) { sample in
                                    LineMark(
                                        x: .value("Time", sample.timestamp),
                                        y: .value("BPM", sample.beatsPerMinute)
                                    )
                                }
                            }
                            .frame(height: 200)
                        } else {
                            Text("No heart rate data available")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Dashboard")
            .task {
                await viewModel.loadHealthData()
            }
            .refreshable {
                await viewModel.loadHealthData()
            }
        }
    }
}

@MainActor
class DashboardViewModel: ObservableObject {
    @Published var stepCount: Int = 0
    @Published var heartRateSamples: [HeartRateSample] = []
    
    func loadHealthData() async {
        do {
            // Fetch today's health data
            let healthData = try await HealthKitService.shared.fetchDailyHealthData(for: Date())
            
            // Update UI
            self.stepCount = healthData.stepCount
            self.heartRateSamples = healthData.heartRateSamples
            
            // Trigger background sync
            Task {
                try await SyncService.shared.syncHealthData(healthData)
            }
        } catch {
            print("Failed to load health data: \(error)")
        }
    }
} 