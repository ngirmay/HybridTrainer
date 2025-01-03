// Common types used in both platforms
export interface TrainingProgram {
    id: string;
    icon: string;
    title: string;
    category: ProgramCategory;
    duration: string;
    description: string;
    sessionDuration: string;
    level: string;
}

export enum ProgramCategory {
    Endurance = "Endurance",
    Strength = "Strength",
    HIIT = "HIIT",
    Recovery = "Recovery",
    Custom = "Custom"
}

export interface UserProfile {
    id: string;
    name: string;
    membershipType: string;
    email: string;
}

export interface ActivityStat {
    value: string;
    unit: string;
    label: string;
}

export interface Workout {
    id: string;
    type: WorkoutType;
    startDate: string;
    endDate: string;
    duration: number;
    distance?: number;
    energyBurned?: number;
    averageHeartRate?: number;
}

export enum WorkoutType {
    Running = "Running",
    Cycling = "Cycling",
    Swimming = "Swimming",
    Strength = "Strength",
    HIIT = "HIIT",
    Other = "Other"
} 