#!/bin/bash

# Source image should be at least 1024x1024
SOURCE_IMAGE="original_logo.png"
ASSET_PATH="HybridTrainer/Assets.xcassets/AppIcon.appiconset"

# Create necessary directories
mkdir -p "$ASSET_PATH"

# iPhone icon sizes
SIZES=(
    "20x20@2x:40"
    "20x20@3x:60"
    "29x29@2x:58"
    "29x29@3x:87"
    "40x40@2x:80"
    "40x40@3x:120"
    "60x60@2x:120"
    "60x60@3x:180"
    "1024x1024:1024"
)

# Generate icons
for SIZE in "${SIZES[@]}"; do
    NAME="${SIZE%%:*}"
    PIXELS="${SIZE##*:}"
    
    echo "Generating $NAME ($PIXELS px)"
    sips -z "$PIXELS" "$PIXELS" "$SOURCE_IMAGE" --out "$ASSET_PATH/Icon-$PIXELS.png"
done

echo "App icons generated successfully!" 