import SwiftUI

struct StatItem: View {
    let icon: String?
    let value: String
    let unit: String
    let label: String?
    
    // Default initializer for program details
    init(icon: String, value: String, unit: String) {
        self.icon = icon
        self.value = value
        self.unit = unit
        self.label = nil
    }
    
    // Analytics initializer
    init(value: String, unit: String, label: String) {
        self.icon = nil
        self.value = value
        self.unit = unit
        self.label = label
    }
    
    var body: some View {
        if let label = label {
            // Analytics style
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
        } else {
            // Program details style
            VStack(spacing: 4) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                }
                
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