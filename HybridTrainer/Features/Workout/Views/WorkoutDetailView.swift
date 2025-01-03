import SwiftUI
import Charts
import UIKit
import HealthKit
import Foundation

struct WorkoutDetailView: View {
    let workoutDetails: WorkoutDetails
    @State private var selectedTab = 0
    @State private var showingShareSheet = false
    @State private var showingMetrics = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Hero Section
                heroSection
                    .transition(.move(edge: .top))
                
                // Stats Grid
                statsGrid
                    .transition(.scale)
                
                // Tabbed Content
                TabView(selection: $selectedTab) {
                    // Heart Rate View
                    heartRateSection
                        .tag(0)
                    
                    // Map View
                    if let route = workoutDetails.route {
                        mapSection(route: route)
                            .tag(1)
                    }
                    
                    // Splits View
                    if !workoutDetails.splits.isEmpty {
                        splitsSection
                            .tag(2)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 350)
            }
            .padding(.vertical)
        }
        .background(Theme.background)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: shareWorkout) {
                        Label("Share Workout", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(action: exportWorkout) {
                        Label("Export as PDF", systemImage: "doc.text")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            ShareSheet(activityItems: [createWorkoutSummary()])
        }
        .onAppear {
            withAnimation(.spring()) {
                showingMetrics = true
            }
        }
    }
    
    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(workoutDetails.workout.workoutActivityType.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Theme.text)
            
            Text(workoutDetails.workout.startDate.formatted(date: .long, time: .shortened))
                .foregroundColor(Theme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private var statsGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(workoutMetrics, id: \.title) { metric in
                StatCard(
                    icon: metric.icon,
                    title: metric.title,
                    value: metric.value
                )
                .scaleEffect(showingMetrics ? 1 : 0)
                .animation(.spring(delay: Double(metric.index) * 0.1), value: showingMetrics)
            }
        }
        .padding(.horizontal)
    }
    
    // ... Additional view components and helper methods
}

// MARK: - Helper Views
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Animations
extension AnyTransition {
    static var slideUpWithOpacity: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .move(edge: .top).combined(with: .opacity)
        )
    }
} 