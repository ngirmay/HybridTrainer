import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                        VStack(alignment: .leading) {
                            Text("John Doe")
                                .font(.title2)
                            Text("Premium Member")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                
                Section("Settings") {
                    Label("Notifications", systemImage: "bell")
                    Label("Privacy", systemImage: "lock")
                    Label("Help", systemImage: "questionmark.circle")
                }
                
                Section {
                    Label("Sign Out", systemImage: "arrow.right.square")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Profile")
        }
    }
} 