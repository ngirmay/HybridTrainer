#!/bin/bash

# Source and destination directories
SOURCE_DIR="AppIcons/ios"
DEST_DIR="HybridTrainer/Assets.xcassets/AppIcon.appiconset"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy iOS app icons
echo "Copying iOS app icons..."
cp "$SOURCE_DIR"/*.png "$DEST_DIR/"

# Copy logo for in-app use
echo "Copying logo for in-app use..."
mkdir -p "HybridTrainer/Assets.xcassets/Logo.imageset"
cp "AppIcons/logo.png" "HybridTrainer/Assets.xcassets/Logo.imageset/HybridTrainerLogo.png"
cp "AppIcons/logo@2x.png" "HybridTrainer/Assets.xcassets/Logo.imageset/HybridTrainerLogo@2x.png"
cp "AppIcons/logo@3x.png" "HybridTrainer/Assets.xcassets/Logo.imageset/HybridTrainerLogo@3x.png"

echo "Icons copied successfully!" 