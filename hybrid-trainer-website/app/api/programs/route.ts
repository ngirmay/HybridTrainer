import { TrainingProgram } from '@/types/shared';

export async function GET() {
    // TODO: Replace with actual database call
    const programs: TrainingProgram[] = [
        {
            id: "1",
            icon: "running",
            title: "Endurance Builder",
            category: "Endurance",
            duration: "12-week program",
            description: "Build your endurance with this comprehensive program.",
            sessionDuration: "45-60",
            level: "Intermediate"
        }
        // ... more programs
    ];

    return Response.json({ programs });
} 