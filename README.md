# Hybrid Trainer

An iOS app for tracking and managing Ironman training plans.

## Setup

1. Install XcodeGen:
```bash
brew install xcodegen
```

2. Generate the Xcode project:
```bash
./Scripts/generate-project.sh
```

3. Open the project:
```bash
open HybridTrainer.xcodeproj
```

## Development

- The app uses SwiftUI for the UI
- Training plan data is stored in `Resources/training_plan.json`
- Project structure is managed by XcodeGen

## Building

The project uses GitHub Actions for CI/CD. To build locally:

```bash
xcodebuild clean build -project HybridTrainer.xcodeproj -scheme HybridTrainer -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.0'
```

