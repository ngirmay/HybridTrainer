//
//  GoalCard.swift
//  HybridTrainer
//
//  Created by Nobel Girmay on 12/11/24.
//

import SwiftUI
import Models

public struct GoalCard: View {
    let goal: Goal
    
    private let hexagonSize: CGFloat = 40
    private let cornerRadius: CGFloat = 12
    
    public init(goal: Goal) {
        self.goal = goal
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                // Hexagonal progress indicator
                ZStack {
                    // Background hexagon
                    RegularPolygon(sides: 6)
                        .stroke(Theme.Colors.secondary.opacity(0.15), lineWidth: 2)
                        .frame(width: hexagonSize, height: hexagonSize)
                    
                    // Progress hexagon
                    RegularPolygon(sides: 6)
                        .trim(from: 0, to: goal.progress)
                        .stroke(goal.type.color, lineWidth: 2)
                        .frame(width: hexagonSize, height: hexagonSize)
                    
                    // Icon
                    Image(systemName: goal.type.icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Theme.Colors.primary)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Theme.Colors.primary)
                    
                    Text(goal.targetDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Theme.Colors.secondary)
                }
                
                Spacer()
                
                Text(String(format: "%.1f/%.1f km", goal.currentValue, goal.targetValue))
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Theme.Colors.secondary)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    Capsule()
                        .fill(Theme.Colors.secondary.opacity(0.1))
                        .frame(height: 4)
                    
                    // Progress bar
                    Capsule()
                        .fill(goal.type.color)
                        .frame(width: geometry.size.width * goal.progress, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(Theme.Colors.cardBackground)
        }
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Theme.Colors.secondary.opacity(0.1), lineWidth: 1)
        }
    }
}

// Helper shape for hexagon
struct RegularPolygon: Shape {
    let sides: Int
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let angle = Double.pi * 2 / Double(sides)
        
        var path = Path()
        
        for i in 0..<sides {
            let currentAngle = angle * Double(i) - Double.pi / 2
            let x = center.x + CGFloat(cos(currentAngle)) * radius
            let y = center.y + CGFloat(sin(currentAngle)) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
    
    func trim(from: Double, to: Double) -> some Shape {
        TrimmedShape(shape: self, from: from, to: to)
    }
}

#Preview {
    VStack(spacing: 20) {
        GoalCard(goal: Goal(
            name: "Complete Half Marathon",
            targetDate: Date().addingTimeInterval(7*24*3600),
            type: .run,
            targetValue: 21.1,
            currentValue: 15.0
        ))
        
        GoalCard(goal: Goal(
            name: "Weekly Swim Distance",
            targetDate: Date().addingTimeInterval(2*24*3600),
            type: .swim,
            targetValue: 3.0,
            currentValue: 3.0,
            completed: true
        ))
    }
    .padding()
    .background(Color(.systemGray6))
}
