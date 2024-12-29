import SwiftUI

struct TrainingPlanView: View {
    @State private var trainingPlan: TrainingPlan?
    
    var body: some View {
        NavigationView {
            Group {
                if let plan = trainingPlan {
                    List(plan.phases, id: \.name) { phase in
                        Section(header: Text(phase.name)) {
                            ForEach(phase.weeks.indices, id: \.self) { index in
                                NavigationLink(destination: WeekDetailView(week: phase.weeks[index])) {
                                    Text("Week \(index + 1)")
                                }
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Training Plan")
            .onAppear(perform: loadTrainingPlan)
        }
    }
    
    private func loadTrainingPlan() {
        guard let url = Bundle.main.url(forResource: "training_plan", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let plan = try? JSONDecoder().decode(TrainingPlan.self, from: data) else {
            return
        }
        self.trainingPlan = plan
    }
}

struct WeekDetailView: View {
    let week: Week
    
    var body: some View {
        List {
            ForEach(week.workouts, id: \.dayOfWeek) { workout in
                VStack(alignment: .leading) {
                    Text(workout.dayOfWeek)
                        .font(.headline)
                    Text(workout.description)
                        .font(.body)
                }
            }
            
            if let runMileage = week.runMileage {
                Text("Run: \(runMileage, specifier: "%.1f") miles")
            }
            if let bikeMileage = week.bikeMileage {
                Text("Bike: \(bikeMileage, specifier: "%.1f") miles")
            }
            if let swimMileage = week.swimMileage {
                Text("Swim: \(swimMileage, specifier: "%.1f") miles")
            }
        }
        .navigationTitle("Week Details")
    }
} 