import Foundation

struct TrainingProgram: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let category: ProgramCategory
    let duration: String
    let description: String
    let sessionDuration: String
    let level: String
}

enum ProgramCategory: String, CaseIterable {
    case endurance = "Endurance"
    case strength = "Strength"
    case hiit = "HIIT"
    case recovery = "Recovery"
    case custom = "Custom"
}

// Sample Programs
let samplePrograms: [TrainingProgram] = [
    TrainingProgram(
        icon: "figure.run",
        title: "Endurance Builder",
        category: .endurance,
        duration: "12-week program",
        description: "Build your endurance with this comprehensive program designed to improve your stamina and cardiovascular fitness.",
        sessionDuration: "45-60",
        level: "Intermediate"
    ),
    TrainingProgram(
        icon: "dumbbell.fill",
        title: "Strength Master",
        category: .strength,
        duration: "8-week program",
        description: "Focus on building strength and muscle mass with this intensive program designed for serious athletes.",
        sessionDuration: "60-75",
        level: "Advanced"
    ),
    TrainingProgram(
        icon: "timer",
        title: "HIIT Challenge",
        category: .hiit,
        duration: "6-week program",
        description: "Transform your fitness with high-intensity interval training designed to maximize calorie burn and improve conditioning.",
        sessionDuration: "30-45",
        level: "All levels"
    )
] 