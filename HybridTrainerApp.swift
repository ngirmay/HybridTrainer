let container = try! ModelContainer(
    for: TrainingSession.self, PlannedWorkout.self, TrainingBlock.self,
    configurations: ModelConfiguration(schema: Schema([
        TrainingSession.self,
        PlannedWorkout.self,
        TrainingBlock.self
    ], version: 2)) // Increment version for migration
) 