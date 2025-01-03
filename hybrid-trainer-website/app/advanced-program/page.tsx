import { useState } from 'react'
import { Button } from "@/components/ui/button"
import { Textarea } from "@/components/ui/textarea"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import { Calendar, Dumbbell, Bike, FishIcon as Swim, Zap, Clock } from 'lucide-react'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Label } from "@/components/ui/label"
import { Input } from "@/components/ui/input"
import { UserMetrics } from "@/components/user-metrics"

export default function AdvancedProgramPage() {
  const [prompt, setPrompt] = useState('')
  const [generatedPlan, setGeneratedPlan] = useState(null)
  const [fitnessLevel, setFitnessLevel] = useState('intermediate')
  const [primaryGoal, setPrimaryGoal] = useState('endurance')
  const [weeklyHours, setWeeklyHours] = useState('10')

  const handleGeneratePlan = () => {
    // This is where we'd normally call our AI service to generate the plan
    // For now, we'll just set a mock plan
    const mockPlan = {
      phase1: {
        duration: '8 weeks',
        focus: 'Biking emphasis',
        weeklyStructure: [
          { day: 'Monday', activity: 'Lift (full-body or lower-body focus)', icon: 'dumbbell' },
          { day: 'Tuesday', activity: 'Bike – Intervals (Z3–Z4)', icon: 'bike' },
          { day: 'Wednesday', activity: 'Swim (short technique session)', icon: 'swim' },
          { day: 'Thursday', activity: 'Bike – Easy or Endurance ride', icon: 'bike' },
          { day: 'Friday', activity: 'Lift (upper-body + core or power-based)', icon: 'dumbbell' },
          { day: 'Saturday', activity: 'Long Bike (progressing from 1.5 hours to 3 hours)', icon: 'bike' },
          { day: 'Sunday', activity: 'Rest or easy walk/jog', icon: 'calendar' },
        ]
      },
      phase2: {
        duration: '4 weeks',
        focus: 'Plyometrics focus',
        weeklyStructure: [
          { day: 'Monday', activity: 'Plyometric Circuit (box jumps, bounds, etc.)', icon: 'zap' },
          { day: 'Tuesday', activity: 'Bike – Short intervals (maintenance)', icon: 'bike' },
          { day: 'Wednesday', activity: 'Lift (strength/power)', icon: 'dumbbell' },
          { day: 'Thursday', activity: 'Plyometric Circuit #2 (maybe focusing on single-leg power)', icon: 'zap' },
          { day: 'Friday', activity: 'Rest / light activity (mobility)', icon: 'calendar' },
          { day: 'Saturday', activity: 'Bike – Moderately paced (1–2 hours max)', icon: 'bike' },
          { day: 'Sunday', activity: 'Optional easy swim or rest', icon: 'swim' },
        ]
      }
    }
    setGeneratedPlan(mockPlan)
  }

  return (
    <div className="container space-y-8 px-4 py-8 md:px-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Advanced Training Program Generator</h1>
        <p className="text-muted-foreground mt-2">
          Describe your training goals, and our AI will generate a personalized program.
        </p>
      </div>

      <UserMetrics />

      <Card>
        <CardHeader>
          <CardTitle>Enter Your Training Details</CardTitle>
          <CardDescription>
            Provide information about your goals and current fitness level to generate a tailored plan.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid gap-6">
            <div className="grid gap-2">
              <Label htmlFor="prompt">Training Prompt</Label>
              <Textarea
                id="prompt"
                placeholder="E.g., 2 months of biking – plyometric/explosive cycle after 2 months – swim once a week – and lift twice a week during the biking cycle"
                value={prompt}
                onChange={(e) => setPrompt(e.target.value)}
                className="min-h-[100px]"
              />
            </div>
            <div className="grid gap-4 sm:grid-cols-3">
              <div className="grid gap-2">
                <Label htmlFor="fitness-level">Fitness Level</Label>
                <Select value={fitnessLevel} onValueChange={setFitnessLevel}>
                  <SelectTrigger id="fitness-level">
                    <SelectValue placeholder="Select fitness level" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="beginner">Beginner</SelectItem>
                    <SelectItem value="intermediate">Intermediate</SelectItem>
                    <SelectItem value="advanced">Advanced</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="primary-goal">Primary Goal</Label>
                <Select value={primaryGoal} onValueChange={setPrimaryGoal}>
                  <SelectTrigger id="primary-goal">
                    <SelectValue placeholder="Select primary goal" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="endurance">Endurance</SelectItem>
                    <SelectItem value="strength">Strength</SelectItem>
                    <SelectItem value="speed">Speed</SelectItem>
                    <SelectItem value="weight-loss">Weight Loss</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="weekly-hours">Weekly Training Hours</Label>
                <Input
                  id="weekly-hours"
                  type="number"
                  min="1"
                  max="40"
                  value={weeklyHours}
                  onChange={(e) => setWeeklyHours(e.target.value)}
                />
              </div>
            </div>
            <Button onClick={handleGeneratePlan} className="w-full sm:w-auto">Generate Plan</Button>
          </div>
        </CardContent>
      </Card>

      {generatedPlan && (
        <Card>
          <CardHeader>
            <CardTitle>Your Personalized Training Plan</CardTitle>
            <CardDescription>
              Based on your input and fitness profile, here's your tailored training program.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-8">
              {Object.entries(generatedPlan).map(([phase, data]) => (
                <div key={phase} className="space-y-4">
                  <h3 className="text-xl font-semibold">{phase.charAt(0).toUpperCase() + phase.slice(1)}</h3>
                  <div className="flex items-center gap-4">
                    <div className="flex items-center gap-2">
                      <Clock className="h-5 w-5 text-muted-foreground" />
                      <span className="text-sm text-muted-foreground">Duration: {data.duration}</span>
                    </div>
                    <div className="flex items-center gap-2">
                      <Zap className="h-5 w-5 text-muted-foreground" />
                      <span className="text-sm text-muted-foreground">Focus: {data.focus}</span>
                    </div>
                  </div>
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead className="w-[100px]">Day</TableHead>
                        <TableHead>Activity</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {data.weeklyStructure.map((day, index) => (
                        <TableRow key={index}>
                          <TableCell className="font-medium">{day.day}</TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              {day.icon === 'bike' && <Bike className="h-4 w-4 text-primary" />}
                              {day.icon === 'swim' && <Swim className="h-4 w-4 text-primary" />}
                              {day.icon === 'dumbbell' && <Dumbbell className="h-4 w-4 text-primary" />}
                              {day.icon === 'calendar' && <Calendar className="h-4 w-4 text-primary" />}
                              {day.icon === 'zap' && <Zap className="h-4 w-4 text-primary" />}
                              <span>{day.activity}</span>
                            </div>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}

