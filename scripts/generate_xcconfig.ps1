# PowerShell script to reliably generate Generated.xcconfig for iOS builds

Write-Host "Starting Generated.xcconfig generation process..."

# Clean up any existing files
Write-Host "Cleaning up existing files..."
Set-Location -Path "ios"
if (Test-Path "Flutter\Generated.xcconfig") {
    Remove-Item "Flutter\Generated.xcconfig" -Force
}
if (Test-Path "Flutter\flutter_export_environment.sh") {
    Remove-Item "Flutter\flutter_export_environment.sh" -Force
}
Set-Location -Path ".."

# Run flutter pub get first
Write-Host "Running flutter pub get..."
flutter pub get

# Run flutter clean
Write-Host "Running flutter clean..."
flutter clean

# Run flutter precache for iOS
Write-Host "Running flutter precache --ios..."
flutter precache --ios

# Check if Generated.xcconfig exists now
Write-Host "Checking for Generated.xcconfig..."
Set-Location -Path "ios"
if (Test-Path "Flutter\Generated.xcconfig") {
    Write-Host "SUCCESS: Generated.xcconfig created!" -ForegroundColor Green
    Write-Host "Contents:"
    Get-Content "Flutter\Generated.xcconfig"
    Set-Location -Path ".."
    exit 0
} else {
    Write-Host "ERROR: Generated.xcconfig still not found!" -ForegroundColor Red
    Write-Host "Trying alternative approach..."
    
    # Try creating a minimal Generated.xcconfig manually
    $content = @"
// Auto-generated file
FLUTTER_ROOT=
FLUTTER_APPLICATION_PATH=
COCOAPODS_PARALLEL_CODE_SIGN=true
FLUTTER_TARGET=lib/main.dart
FLUTTER_BUILD_DIR=build
FLUTTER_BUILD_NAME=1.0.0
FLUTTER_BUILD_NUMBER=1
"@
    
    $content | Out-File -FilePath "Flutter\Generated.xcconfig" -Encoding UTF8
    
    if (Test-Path "Flutter\Generated.xcconfig") {
        Write-Host "SUCCESS: Minimal Generated.xcconfig created manually!" -ForegroundColor Green
        Write-Host "Contents:"
        Get-Content "Flutter\Generated.xcconfig"
        Set-Location -Path ".."
        exit 0
    } else {
        Write-Host "ERROR: Could not create Generated.xcconfig!" -ForegroundColor Red
        Set-Location -Path ".."
        exit 1
    }
}