import SwiftUI
import Charts

struct WorkoutDetailView: View {
    let workoutDetails: WorkoutDetails
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Summary Card
                WorkoutSummaryCard(workout: workoutDetails.workout)
                
                // Heart Rate Chart
                Chart {
                    ForEach(workoutDetails.heartRateData, id: \.timestamp) { sample in
                        LineMark(
                            x: .value("Time", sample.timestamp),
                            y: .value("BPM", sample.value)
                        )
                    }
                }
                .frame(height: 200)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5))
                }
                
                // Splits
                if !workoutDetails.splits.isEmpty {
                    SplitsView(splits: workoutDetails.splits)
                }
                
                // Map
                if let route = workoutDetails.route {
                    WorkoutMapView(route: route)
                }
            }
            .padding()
        }
        .navigationTitle("Workout Details")
    }
} 