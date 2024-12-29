#!/bin/sh

# Check if XcodeGen is installed
if ! command -v xcodegen &> /dev/null; then
    echo "XcodeGen is not installed. Installing via Homebrew..."
    brew install xcodegen
fi

# Generate the project
echo "Generating Xcode project..."
xcodegen generate

echo "Project generation complete!" 