import SwiftUI

struct StatItem: View {
    let icon: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(.body, design: .rounded, weight: .semibold))
                if !unit.isEmpty {
                    Text(unit)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
        }
    }
} 