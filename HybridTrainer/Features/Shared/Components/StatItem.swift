import SwiftUI

struct StatItem: View {
    let value: String
    let unit: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                Text(unit)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Analytics style
        StatItem(value: "26.2", unit: "mi", label: "Run")
        
        // Program details style
        StatItem(icon: "clock", value: "45-60", unit: "min")
    }
    .padding()
} 