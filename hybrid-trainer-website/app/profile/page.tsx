import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Separator } from "@/components/ui/separator"
import { Switch } from "@/components/ui/switch"
import { Camera, Dna, Smartphone, User } from 'lucide-react'

export default function ProfilePage() {
  return (
    <div className="container space-y-8 px-4 py-8 md:px-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Profile</h1>
        <p className="text-muted-foreground">
          Manage your account settings and training preferences.
        </p>
      </div>

      <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3">
        <Card>
          <CardHeader>
            <CardTitle>Personal Information</CardTitle>
            <CardDescription>Update your personal details and preferences.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="flex items-center gap-4">
              <div className="relative">
                <div className="aspect-square w-20 overflow-hidden rounded-full bg-muted">
                  <User className="h-full w-full p-4 text-muted-foreground" />
                </div>
                <Button
                  size="icon"
                  variant="outline"
                  className="absolute -bottom-2 -right-2 h-8 w-8 rounded-full"
                >
                  <Camera className="h-4 w-4" />
                </Button>
              </div>
              <div className="flex-1">
                <p className="font-medium">Profile Photo</p>
                <p className="text-sm text-muted-foreground">
                  Upload a new profile photo or remove the current one.
                </p>
              </div>
            </div>
            <Separator />
            <div className="grid gap-4">
              <div className="grid gap-2">
                <Label htmlFor="name">Full Name</Label>
                <Input id="name" placeholder="Enter your full name" />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="email">Email</Label>
                <Input id="email" placeholder="Enter your email" type="email" />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="phone">Phone</Label>
                <Input id="phone" placeholder="Enter your phone number" type="tel" />
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <div className="flex items-center gap-4">
              <Dna className="h-8 w-8 text-primary" />
              <div>
                <CardTitle>Training Profile</CardTitle>
                <CardDescription>Configure your training preferences.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid gap-4">
              <div className="grid gap-2">
                <Label htmlFor="level">Experience Level</Label>
                <Select defaultValue="intermediate">
                  <SelectTrigger id="level">
                    <SelectValue placeholder="Select experience level" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="beginner">Beginner</SelectItem>
                    <SelectItem value="intermediate">Intermediate</SelectItem>
                    <SelectItem value="advanced">Advanced</SelectItem>
                    <SelectItem value="professional">Professional</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="goal">Primary Goal</Label>
                <Select defaultValue="strength">
                  <SelectTrigger id="goal">
                    <SelectValue placeholder="Select primary goal" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="endurance">Endurance</SelectItem>
                    <SelectItem value="strength">Strength</SelectItem>
                    <SelectItem value="speed">Speed</SelectItem>
                    <SelectItem value="flexibility">Flexibility</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid gap-2">
                <Label htmlFor="availability">Weekly Availability</Label>
                <Select defaultValue="3-4">
                  <SelectTrigger id="availability">
                    <SelectValue placeholder="Select weekly availability" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="1-2">1-2 days per week</SelectItem>
                    <SelectItem value="3-4">3-4 days per week</SelectItem>
                    <SelectItem value="5-6">5-6 days per week</SelectItem>
                    <SelectItem value="7">Every day</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <Separator />
            <Button className="w-full">Save Changes</Button>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <div className="flex items-center gap-4">
              <Smartphone className="h-8 w-8 text-primary" />
              <div>
                <CardTitle>iOS App Preferences</CardTitle>
                <CardDescription>Set your preferences for the upcoming iOS app.</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid gap-4">
              <div className="flex items-center justify-between">
                <Label htmlFor="beta-access">Join Beta Program</Label>
                <Switch id="beta-access" />
              </div>
              <div className="flex items-center justify-between">
                <Label htmlFor="push-notifications">Enable Push Notifications</Label>
                <Switch id="push-notifications" />
              </div>
              <div className="grid gap-2">
                <Label htmlFor="data-sync">Data Sync Frequency</Label>
                <Select defaultValue="realtime">
                  <SelectTrigger id="data-sync">
                    <SelectValue placeholder="Select sync frequency" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="realtime">Real-time</SelectItem>
                    <SelectItem value="hourly">Hourly</SelectItem>
                    <SelectItem value="daily">Daily</SelectItem>
                    <SelectItem value="manual">Manual</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <Separator />
            <p className="text-sm text-muted-foreground">
              Note: These preferences will take effect once the iOS app is released. You&apos;ll be notified when it&apos;s available for download.
            </p>
            <Button className="w-full">Save iOS App Preferences</Button>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

