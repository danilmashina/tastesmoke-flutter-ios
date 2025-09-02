#!/bin/bash

# Script to reliably generate Generated.xcconfig for iOS builds

echo "Starting Generated.xcconfig generation process..."

# Clean up any existing files
echo "Cleaning up existing files..."
cd ios
rm -f Flutter/Generated.xcconfig
rm -f Flutter/flutter_export_environment.sh
cd ..

# Run flutter pub get first
echo "Running flutter pub get..."
flutter pub get

# Run flutter clean
echo "Running flutter clean..."
flutter clean

# Run flutter precache for iOS
echo "Running flutter precache --ios..."
flutter precache --ios

# Check if Generated.xcconfig exists now
echo "Checking for Generated.xcconfig..."
cd ios
if [ -f "Flutter/Generated.xcconfig" ]; then
    echo "SUCCESS: Generated.xcconfig created!"
    echo "Contents:"
    cat Flutter/Generated.xcconfig
    cd ..
    exit 0
else
    echo "ERROR: Generated.xcconfig still not found!"
    echo "Trying alternative approach..."
    
    # Try creating a minimal Generated.xcconfig manually
    echo "// Auto-generated file" > Flutter/Generated.xcconfig
    echo "FLUTTER_ROOT=" >> Flutter/Generated.xcconfig
    echo "FLUTTER_APPLICATION_PATH=" >> Flutter/Generated.xcconfig
    echo "COCOAPODS_PARALLEL_CODE_SIGN=true" >> Flutter/Generated.xcconfig
    echo "FLUTTER_TARGET=lib/main.dart" >> Flutter/Generated.xcconfig
    echo "FLUTTER_BUILD_DIR=build" >> Flutter/Generated.xcconfig
    echo "FLUTTER_BUILD_NAME=1.0.0" >> Flutter/Generated.xcconfig
    echo "FLUTTER_BUILD_NUMBER=1" >> Flutter/Generated.xcconfig
    
    if [ -f "Flutter/Generated.xcconfig" ]; then
        echo "SUCCESS: Minimal Generated.xcconfig created manually!"
        echo "Contents:"
        cat Flutter/Generated.xcconfig
        cd ..
        exit 0
    else
        echo "ERROR: Could not create Generated.xcconfig!"
        cd ..
        exit 1
    fi
fi