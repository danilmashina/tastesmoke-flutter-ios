#!/bin/bash

# Script to fix Generated.xcconfig file for macOS builds
# This addresses the issue where Windows paths are in the Generated.xcconfig file

echo "Fixing Generated.xcconfig for macOS build environment..."

# Navigate to the iOS directory
cd ios

# Remove the existing Generated.xcconfig file
if [ -f "Flutter/Generated.xcconfig" ]; then
    echo "Removing existing Generated.xcconfig..."
    rm Flutter/Generated.xcconfig
fi

# Go back to the root directory
cd ..

# Run flutter precache to regenerate the file with correct paths
echo "Regenerating Generated.xcconfig with correct paths..."
flutter precache --ios

# Verify the file was created
if [ -f "ios/Flutter/Generated.xcconfig" ]; then
    echo "Generated.xcconfig successfully regenerated!"
    echo "Contents:"
    cat ios/Flutter/Generated.xcconfig
else
    echo "ERROR: Generated.xcconfig was not created!"
    exit 1
fi

echo "Fix completed successfully!"