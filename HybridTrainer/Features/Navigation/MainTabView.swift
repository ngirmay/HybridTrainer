import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tag(0)
                
                TrainingPlanView()
                    .tag(1)
                
                AnalyticsView()
                    .tag(2)
                
                ProfileView()
                    .tag(3)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
} 