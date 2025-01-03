import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { Dumbbell, MonitorIcon as Running, Timer, Waves } from 'lucide-react'

export default function TrainingPage() {
  return (
    <div className="container space-y-8 px-4 py-8 md:px-6">
      <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Training Programs</h1>
          <p className="text-muted-foreground">
            Choose from our personalized training programs or create your own.
          </p>
        </div>
        <Button>Create Program</Button>
      </div>

      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {[
          {
            icon: Running,
            title: "Endurance Builder",
            description: "12-week program",
            content: "Build your endurance with this comprehensive program designed to improve your stamina and cardiovascular fitness.",
            duration: "45-60 min/session",
            level: "Intermediate"
          },
          {
            icon: Dumbbell,
            title: "Strength Master",
            description: "8-week program",
            content: "Focus on building strength and muscle mass with this intensive program designed for serious athletes.",
            duration: "60-75 min/session",
            level: "Advanced"
          },
          {
            icon: Timer,
            title: "HIIT Challenge",
            description: "6-week program",
            content: "Transform your fitness with high-intensity interval training designed to maximize calorie burn and improve conditioning.",
            duration: "30-45 min/session",
            level: "All levels"
          }
        ].map((program, index) => (
          <Card key={index}>
            <CardHeader>
              <div className="flex items-center gap-4">
                <div className="relative aspect-square w-12 overflow-hidden rounded-lg bg-primary">
                  <program.icon className="absolute left-1/2 top-1/2 h-6 w-6 -translate-x-1/2 -translate-y-1/2 text-primary-foreground" />
                </div>
                <div>
                  <CardTitle>{program.title}</CardTitle>
                  <CardDescription>{program.description}</CardDescription>
                </div>
              </div>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <p className="text-sm text-muted-foreground">
                  {program.content}
                </p>
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div className="flex items-center gap-2">
                    <Timer className="h-4 w-4 text-muted-foreground" />
                    <span>{program.duration}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Waves className="h-4 w-4 text-muted-foreground" />
                    <span>{program.level}</span>
                  </div>
                </div>
                <Button className="w-full">Start Program</Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}

