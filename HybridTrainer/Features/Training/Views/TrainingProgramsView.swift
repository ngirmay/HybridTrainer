import SwiftUI

struct TrainingProgramsView: View {
    @State private var showingCreateProgram = false
    @State private var selectedCategory: ProgramCategory = .endurance
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Category Selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(ProgramCategory.allCases, id: \.self) { category in
                                CategoryButton(
                                    category: category,
                                    isSelected: category == selectedCategory,
                                    action: { withAnimation { selectedCategory = category } }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Programs Grid
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                        ForEach(samplePrograms.filter { $0.category == selectedCategory }) { program in
                            NavigationLink(destination: ProgramDetailsView(program: program)) {
                                ProgramCard(program: program)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Training Programs")
            .navigationBarItems(trailing: CreateProgramButton(showingSheet: $showingCreateProgram))
        }
        .sheet(isPresented: $showingCreateProgram) {
            CreateProgramView()
        }
    }
}

struct ProgramCard: View {
    let program: TrainingProgram
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 12) {
                Image(systemName: program.icon)
                    .font(.system(size: 24))
                    .frame(width: 48, height: 48)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(program.title)
                        .font(.system(size: 20, weight: .bold))
                    Text(program.duration)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            // Description
            Text(program.description)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .lineSpacing(4)
            
            // Stats
            HStack(spacing: 24) {
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                    Text("\(program.sessionDuration) min/session")
                        .font(.system(size: 14))
                }
                
                HStack(spacing: 8) {
                    Image(systemName: "chart.bar.fill")
                    Text(program.level)
                        .font(.system(size: 14))
                }
            }
            .foregroundColor(.gray)
            
            // Start Button
            Button(action: {}) {
                Text("Start Program")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.black)
                    .cornerRadius(24)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct CreateProgramButton: View {
    @Binding var showingSheet: Bool
    
    var body: some View {
        Button(action: { showingSheet.toggle() }) {
            Text("Create Program")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.black)
                .cornerRadius(20)
        }
    }
}

#Preview {
    TrainingProgramsView()
} 