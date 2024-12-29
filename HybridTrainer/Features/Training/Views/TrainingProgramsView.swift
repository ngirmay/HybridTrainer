import SwiftUI

struct TrainingProgramsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Coming Soon")
                        .font(.title)
                    Text("Training programs will be available in the next update")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationTitle("Training")
        }
    }
}

#Preview {
    TrainingProgramsView()
} 