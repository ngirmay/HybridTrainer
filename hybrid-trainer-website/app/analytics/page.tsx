import { Suspense } from 'react'
import { WorkoutAnalytics, ProgressCharts } from '@/components'

export default function AnalyticsPage() {
  return (
    <main className="p-4">
      <h1 className="text-2xl font-bold mb-6">Analytics</h1>
      <Suspense fallback={<div>Loading analytics...</div>}>
        <WorkoutAnalytics />
        <ProgressCharts />
      </Suspense>
    </main>
  )
}

