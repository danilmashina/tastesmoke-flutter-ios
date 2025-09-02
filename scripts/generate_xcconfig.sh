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
    
    # Проверяем, есть ли FLUTTER_ROOT в файле
    if grep -q "FLUTTER_ROOT" Flutter/Generated.xcconfig; then
        echo "FLUTTER_ROOT found in Generated.xcconfig"
    else
        echo "FLUTTER_ROOT not found, adding it..."
        # Получаем путь к Flutter
        FLUTTER_PATH=$(which flutter)
        FLUTTER_ROOT=$(dirname "$(dirname "$FLUTTER_PATH")")
        echo "FLUTTER_ROOT=$FLUTTER_ROOT" >> Flutter/Generated.xcconfig
        echo "Added FLUTTER_ROOT: $FLUTTER_ROOT"
    fi
    
    cd ..
    exit 0
else
    echo "ERROR: Generated.xcconfig still not found!"
    echo "Trying alternative approach..."
    
    # Try creating a minimal Generated.xcconfig manually
    FLUTTER_PATH=$(which flutter)
    FLUTTER_ROOT=$(dirname "$(dirname "$FLUTTER_PATH")")
    
    cat > Flutter/Generated.xcconfig << EOF
// Auto-generated file
FLUTTER_ROOT=$FLUTTER_ROOT
FLUTTER_APPLICATION_PATH=$(pwd)
COCOAPODS_PARALLEL_CODE_SIGN=true
FLUTTER_TARGET=lib/main.dart
FLUTTER_BUILD_DIR=build
FLUTTER_BUILD_NAME=1.0.0
FLUTTER_BUILD_NUMBER=1
FLUTTER_CLI_BUILD_MODE=debug
EXCLUDED_ARCHS[sdk=iphonesimulator*]=i386
DART_OBFUSCATION=false
TRACK_WIDGET_CREATION=true
TREE_SHAKE_ICONS=false
EOF
    
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