import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
            
            GoalsView(modelContext: modelContext)
                .tabItem {
                    Label("Goals", systemImage: "flag.fill")
                }
            
            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "figure.run")
                }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Goal.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
} 