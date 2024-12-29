import SwiftUI

struct MainTabView: View {
    init() {
        // Set the tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // Set the selected item color
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        // Set the unselected item color
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        // Apply the appearance
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.fill")
                }
            
            TrainingPlanView()
                .tabItem {
                    Label("Training", systemImage: "figure.run")
                }
            
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
} 