import { prisma } from '@/lib/prisma';
import { DailyHealthData } from '@/types/shared';

export async function POST(request: Request) {
    const healthData: DailyHealthData = await request.json();
    
    // Store in database
    const result = await prisma.healthData.create({
        data: {
            date: new Date(healthData.date),
            stepCount: healthData.stepCount,
            averageHeartRate: healthData.averageHeartRate,
            heartRateSamples: {
                create: healthData.heartRateSamples.map(sample => ({
                    timestamp: new Date(sample.timestamp),
                    beatsPerMinute: sample.beatsPerMinute
                }))
            }
        }
    });
    
    return Response.json({ success: true, id: result.id });
} 