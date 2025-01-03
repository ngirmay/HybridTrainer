import Image from "next/image"
import Link from "next/link"
import { Activity, BarChart2, Bell, Clock, Dna, LineChart, MonitorIcon as Running, Smartphone, Zap } from 'lucide-react'
import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"

export default function Page() {
  return (
    <>
      <section className="container px-4 py-24 md:px-6 lg:py-32">
        <div className="flex flex-col items-center gap-4 text-center">
          <div className="flex gap-4">
            <div className="relative aspect-square w-16 overflow-hidden rounded-lg bg-primary md:w-20">
              <Dna className="absolute left-1/2 top-1/2 h-10 w-10 -translate-x-1/2 -translate-y-1/2 text-primary-foreground md:h-12 md:w-12" />
            </div>
            <div className="relative aspect-square w-16 overflow-hidden rounded-lg bg-primary md:w-20">
              <Running className="absolute left-1/2 top-1/2 h-10 w-10 -translate-x-1/2 -translate-y-1/2 text-primary-foreground md:h-12 md:w-12" />
            </div>
            <div className="relative aspect-square w-16 overflow-hidden rounded-lg bg-primary md:w-20">
              <LineChart className="absolute left-1/2 top-1/2 h-10 w-10 -translate-x-1/2 -translate-y-1/2 text-primary-foreground md:h-12 md:w-12" />
            </div>
          </div>
          <h1 className="text-3xl font-bold sm:text-4xl md:text-5xl lg:text-6xl">
            Transform Your Training with HybridTrainer
          </h1>
          <p className="max-w-[42rem] text-muted-foreground sm:text-xl">
            HybridTrainer combines genetic insights, performance tracking, and advanced analytics to
            revolutionize your athletic journey. Our upcoming iOS app will take your training to the next level.
          </p>
          <div className="flex gap-4">
            <Button size="lg" asChild>
              <Link href="/dashboard">Get Started</Link>
            </Button>
            <Button size="lg" variant="outline" asChild>
              <Link href="#features">Learn More</Link>
            </Button>
          </div>
        </div>
      </section>

      <section
        id="features"
        className="container space-y-12 px-4 py-24 md:px-6"
      >
        <div className="text-center">
          <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl">
            Comprehensive Training Platform
          </h2>
          <p className="mx-auto mt-4 max-w-[42rem] text-muted-foreground">
            Discover how HybridTrainer can help you reach your athletic potential with our suite of
            powerful features, soon to be enhanced by our iOS app integration.
          </p>
        </div>
        <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
          {[
            { icon: Dna, title: "Genetic Analysis", description: "Understand your genetic predispositions and optimize your training accordingly" },
            { icon: Running, title: "Performance Tracking", description: "Monitor your progress with detailed metrics and real-time feedback" },
            { icon: LineChart, title: "Advanced Analytics", description: "Gain insights from your training data with powerful visualization tools" },
            { icon: BarChart2, title: "Progress Reports", description: "Detailed reports and visualizations of your training progress" },
            { icon: Clock, title: "Smart Scheduling", description: "Optimize your training schedule based on your recovery and performance data" },
            { icon: Zap, title: "AI Recommendations", description: "Receive personalized training recommendations powered by AI" },
          ].map((feature, index) => (
            <Card key={index}>
              <CardHeader>
                <feature.icon className="h-10 w-10 text-primary" />
                <CardTitle>{feature.title}</CardTitle>
                <CardDescription>{feature.description}</CardDescription>
              </CardHeader>
              <CardContent>
                {/* Feature content */}
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      <section className="bg-muted/50">
        <div className="container grid gap-12 px-4 py-24 md:grid-cols-2 md:px-6">
          <div className="flex flex-col justify-center space-y-4">
            <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl">
              Coming Soon: iOS App Integration
            </h2>
            <p className="text-muted-foreground">
              We&apos;re excited to announce that our iOS app is currently in development. This powerful
              mobile companion will seamlessly integrate with your HybridTrainer account, bringing the
              full potential of our platform to your fingertips.
            </p>
            <ul className="grid gap-4">
              <li className="flex items-center gap-2">
                <Smartphone className="h-5 w-5 text-primary" />
                <span>Real-time data syncing between web and mobile</span>
              </li>
              <li className="flex items-center gap-2">
                <Bell className="h-5 w-5 text-primary" />
                <span>Smart notifications and workout reminders</span>
              </li>
              <li className="flex items-center gap-2">
                <Zap className="h-5 w-5 text-primary" />
                <span>Offline mode for uninterrupted training</span>
              </li>
            </ul>
            <div className="flex gap-4">
              <Button size="lg" className="w-fit">
                Join Beta Waitlist
              </Button>
              <Button size="lg" variant="outline" className="w-fit">
                Learn More
              </Button>
            </div>
          </div>
          <div className="relative aspect-square overflow-hidden rounded-lg bg-muted md:aspect-auto">
            <Image
              src="/placeholder.svg"
              alt="HybridTrainer iOS App Preview"
              className="object-cover"
              fill
              priority
            />
          </div>
        </div>
      </section>

      <section className="container px-4 py-24 md:px-6">
        <div className="flex flex-col items-center gap-4 text-center">
          <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl">
            Ready to Transform Your Training?
          </h2>
          <p className="max-w-[42rem] text-muted-foreground sm:text-xl">
            Join thousands of athletes who are already using HybridTrainer to reach their full
            potential. Be among the first to experience our iOS app when it launches.
          </p>
          <div className="flex gap-4">
            <Button size="lg">Get Started Now</Button>
            <Button size="lg" variant="outline">
              Join iOS Beta Waitlist
            </Button>
          </div>
        </div>
      </section>
    </>
  )
}

