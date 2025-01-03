import { Suspense } from 'react'
import { ActivityStats, WorkoutList } from '@/components'

export default function DashboardPage() {
  return (
    <main className="p-4">
      <h1 className="text-2xl font-bold mb-6">Dashboard</h1>
      <Suspense fallback={<div>Loading stats...</div>}>
        <ActivityStats />
      </Suspense>
      <Suspense fallback={<div>Loading workouts...</div>}>
        <WorkoutList />
      </Suspense>
    </main>
  )
}

