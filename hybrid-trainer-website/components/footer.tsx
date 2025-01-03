import Link from "next/link"
import { Activity, Github } from 'lucide-react'

export function Footer() {
  return (
    <footer className="border-t">
      <div className="container grid gap-8 py-8 md:grid-cols-2 lg:grid-cols-4">
        <div className="flex flex-col gap-2">
          <div className="flex items-center gap-2">
            <Activity className="h-6 w-6" />
            <span className="text-lg font-bold">HybridTrainer</span>
          </div>
          <p className="text-sm text-muted-foreground">
            Comprehensive app for tracking and optimizing athletic performance
          </p>
        </div>
        <div>
          <h3 className="mb-4 text-sm font-semibold">Product</h3>
          <ul className="space-y-2 text-sm">
            <li>
              <Link href="/features" className="text-muted-foreground hover:text-primary">
                Features
              </Link>
            </li>
            <li>
              <Link href="/pricing" className="text-muted-foreground hover:text-primary">
                Pricing
              </Link>
            </li>
            <li>
              <Link href="/download" className="text-muted-foreground hover:text-primary">
                Download
              </Link>
            </li>
          </ul>
        </div>
        <div>
          <h3 className="mb-4 text-sm font-semibold">Resources</h3>
          <ul className="space-y-2 text-sm">
            <li>
              <Link href="/docs" className="text-muted-foreground hover:text-primary">
                Documentation
              </Link>
            </li>
            <li>
              <Link href="/blog" className="text-muted-foreground hover:text-primary">
                Blog
              </Link>
            </li>
            <li>
              <Link href="/support" className="text-muted-foreground hover:text-primary">
                Support
              </Link>
            </li>
          </ul>
        </div>
        <div>
          <h3 className="mb-4 text-sm font-semibold">Legal</h3>
          <ul className="space-y-2 text-sm">
            <li>
              <Link href="/privacy" className="text-muted-foreground hover:text-primary">
                Privacy
              </Link>
            </li>
            <li>
              <Link href="/terms" className="text-muted-foreground hover:text-primary">
                Terms
              </Link>
            </li>
            <li>
              <Link
                href="https://github.com/ngirmay/HybridTrainer"
                className="flex items-center gap-1 text-muted-foreground hover:text-primary"
              >
                <Github className="h-4 w-4" />
                GitHub
              </Link>
            </li>
          </ul>
        </div>
      </div>
      <div className="border-t">
        <div className="container flex h-16 items-center justify-between">
          <p className="text-sm text-muted-foreground">
            © 2024 HybridTrainer. All rights reserved.
          </p>
          <div className="flex items-center gap-4 text-sm text-muted-foreground">
            <Link href="/privacy" className="hover:text-primary">
              Privacy Policy
            </Link>
            <Link href="/terms" className="hover:text-primary">
              Terms of Service
            </Link>
          </div>
        </div>
      </div>
    </footer>
  )
}

