import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Dna, MonitorIcon as Running, LineChart, BarChart2, Clock, Zap } from 'lucide-react'
import FadeIn from "@/components/fade-in"

export default function FeatureSection() {
  const features = [
    { icon: Dna, title: "Genetic Analysis", description: "Understand your genetic predispositions and optimize your training accordingly" },
    { icon: Running, title: "Performance Tracking", description: "Monitor your progress with detailed metrics and real-time feedback" },
    { icon: LineChart, title: "Advanced Analytics", description: "Gain insights from your training data with powerful visualization tools" },
    { icon: BarChart2, title: "Progress Reports", description: "Detailed reports and visualizations of your training progress" },
    { icon: Clock, title: "Smart Scheduling", description: "Optimize your training schedule based on your recovery and performance data" },
    { icon: Zap, title: "AI Recommendations", description: "Receive personalized training recommendations powered by AI" },
  ]

  return (
    <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
      {features.map((feature, index) => (
        <FadeIn key={index}>
          <Card>
            <CardHeader>
              <feature.icon className="h-10 w-10 text-primary" />
              <CardTitle>{feature.title}</CardTitle>
              <CardDescription>{feature.description}</CardDescription>
            </CardHeader>
            <CardContent>
              {/* Feature content */}
            </CardContent>
          </Card>
        </FadeIn>
      ))}
    </div>
  )
}

