import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    ProfileHeader()
                    
                    // Stats Overview
                    StatsOverview()
                    
                    // Settings List
                    SettingsList()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
        }
    }
}

struct ProfileHeader: View {
    var body: some View {
        VStack(spacing: 16) {
            // Profile Image
            Circle()
                .fill(Color.gray.opacity(0.1))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                )
            
            // Name and Status
            VStack(spacing: 4) {
                Text("John Doe")
                    .font(.system(size: 24, weight: .bold))
                Text("Triathlete")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical)
    }
}

struct StatsOverview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Training Stats")
                .font(.system(size: 20, weight: .bold))
            
            HStack(spacing: 24) {
                StatBox(value: "156", label: "Activities")
                StatBox(value: "890", label: "Miles")
                StatBox(value: "120", label: "Hours")
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

struct StatBox: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct SettingsList: View {
    var body: some View {
        VStack(spacing: 0) {
            SettingsRow(icon: "gear", title: "Settings")
            SettingsRow(icon: "bell", title: "Notifications")
            SettingsRow(icon: "lock", title: "Privacy")
            SettingsRow(icon: "questionmark.circle", title: "Help")
            SettingsRow(icon: "arrow.right.square", title: "Sign Out")
        }
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .frame(width: 24)
                    .foregroundColor(.black)
                
                Text(title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .background(Color.white)
    }
} 