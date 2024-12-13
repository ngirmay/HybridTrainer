

## Overview
The **Hybrid Trainer** application is an advanced tool designed to empower athletes in tracking and optimizing their performance across swimming, cycling, running, and strength training disciplines. By seamlessly integrating data from FORM Swim Goggles, Apple Watch, and Wahoo bike computers, it offers sophisticated analytics to support endurance training objectives, such as achieving success in Ironman 70.3 events.

This repository encapsulates the entire codebase, including core models, backend services, and user interface components, necessary for building and deploying the Hybrid Trainer application.

---

## Repository Structure

### **HybridTrainer.xcodeproj/**
- **Description**: Contains the Xcode project files required to configure, build, and debug the application within the Xcode development environment.
- **Usage**: Essential for compiling the project and conducting device-specific testing.

### **HybridTrainer/**
- **Description**: Core application source code.
- **Contents**:
  - **AppDelegate.swift**: Manages lifecycle events for the application.
  - **SceneDelegate.swift**: Handles window scene configurations, tailored for iOS 13 and newer versions.
  - **ViewController.swift**: Acts as the primary entry point for UI logic and control.

### **HybridTrainerTests/**
- **Description**: Unit tests designed to verify the integrity and functionality of backend services, core models, and general application logic.
- **Usage**: Execute these tests within Xcode to ensure correctness and robustness.

### **HybridTrainerUITests/**
- **Description**: UI-specific tests aimed at validating user interactions, navigation paths, and interface consistency.
- **Usage**: Run these tests to ascertain a seamless user experience across app features.

### **Models/**
- **Description**: Houses the foundational data structures utilized throughout the app.
- **Contents**:
  - **WorkoutModel.swift**: Encapsulates the structure and logic for tracking workout sessions.
  - **UserProfile.swift**: Stores user-specific data and customizable preferences.

### **Services/**
- **Description**: Contains backend logic and integration modules for external APIs.
- **Contents**:
  - **AppleHealthService.swift**: Facilitates integration with Apple Health data streams.
  - **FormSwimService.swift**: Processes and structures swim data from FORM Swim Goggles.
  - **WahooBikeService.swift**: Handles the retrieval and analysis of data from Wahoo bike computers.

### **Views/**
- **Description**: Encompasses all components related to the user interface.
- **Contents**:
  - **DashboardView.swift**: Presents aggregated training data in a visually intuitive format.
  - **GoalProgressView.swift**: Provides dynamic visualizations of goal achievement metrics.
  - **SettingsView.swift**: Offers users control over application preferences and configurations.

### **LICENSE**
- **Description**: Specifies the licensing terms governing the use and distribution of this repository.

### **README.md**
- **Description**: This document provides a detailed overview of the project, alongside setup instructions and development guidelines.

---

## Getting Started

### Prerequisites
- A macOS system with Xcode installed.
- An active Apple Developer account for signing and deploying the application.

### Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/ngirmay/HybridTrainer.git
   cd HybridTrainer
   ```
2. Open the project in Xcode:
   ```bash
   open HybridTrainer.xcodeproj
   ```
3. Configure Apple Developer credentials for code signing:
   - Navigate to **Signing & Capabilities** within Xcode.
   - Add your Apple Developer account.

4. Run the application:
   - Select a target device or simulator in Xcode.
   - Click the **Run** button to build and execute the app.

---

## Development with Cursor AI

### Recommended Workflow
1. **Setup Cursor AI Integration**:
   - Open the repository in Cursor AI.
   - Ensure the IDE is correctly mapped to the project directory.

2. **Code Analysis**:
   - Allow Cursor AI to scan and analyze the codebase for optimization suggestions.
   - Leverage Cursor's tools for refactoring and debugging complex logic.

3. **Feature Development**:
   - **Goal Progression Tracking**:
     - Extend `GoalProgressView.swift` to incorporate advanced achievement tracking logic.
     - Refactor `WorkoutModel.swift` to handle additional performance metrics.
   - **Data Synchronization**:
     - Enhance `AppleHealthService.swift` to accommodate expanded metrics from Apple Watch.
     - Validate synchronization pipelines using Cursor's debugging features.
   - **Interactive Visualization Enhancements**:
     - Introduce dynamic graphing components in `DashboardView.swift` leveraging SwiftUI.
     - Utilize Cursor AI for iterative design and improvement.

4. **Testing and Validation**:
   - Develop corresponding unit tests in `HybridTrainerTests/` for each new feature.
   - Conduct thorough UI validation tests via `HybridTrainerUITests/`.

5. **Version Control**:
   - Use Git for managing changes and collaborative development:
     ```bash
     git add .
     git commit -m "Implemented advanced feature XYZ"
     git push origin main
     ```

---

## Feature Roadmap

1. **Comprehensive Goal Progression**
   - Augment tracking mechanisms for key activities: swimming, cycling, running, and strength training.

2. **Advanced Visual Analytics**
   - Embed interactive, user-friendly graphs to enhance data interpretation.

3. **Cloud Data Synchronization**
   - Enable seamless multi-device data access through cloud storage solutions.

4. **Personalized Training Recommendations**
   - Integrate machine learning models to deliver tailored performance insights and training regimens.

---

## Contributions
- **Nobel Girmay**: Principal developer and architect of the Hybrid Trainer application.

For contributions, please submit a pull request or open an issue to discuss your proposed changes.

---

## License
This project is distributed under the MIT License. Refer to the LICENSE file for comprehensive details.

