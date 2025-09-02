# PowerShell script to fix Generated.xcconfig file for macOS builds
# This addresses the issue where Windows paths are in the Generated.xcconfig file

Write-Host "Fixing Generated.xcconfig for macOS build environment..."

# Navigate to the iOS directory
Set-Location -Path "ios"

# Remove the existing Generated.xcconfig file
if (Test-Path "Flutter\Generated.xcconfig") {
    Write-Host "Removing existing Generated.xcconfig..."
    Remove-Item "Flutter\Generated.xcconfig" -Force
}

# Go back to the root directory
Set-Location -Path ".."

# Run flutter precache to regenerate the file with correct paths
Write-Host "Regenerating Generated.xcconfig with correct paths..."
flutter precache --ios

# Verify the file was created
if (Test-Path "ios\Flutter\Generated.xcconfig") {
    Write-Host "Generated.xcconfig successfully regenerated!"
    Write-Host "Contents:"
    Get-Content "ios\Flutter\Generated.xcconfig"
} else {
    Write-Host "ERROR: Generated.xcconfig was not created!"
    exit 1
}

Write-Host "Fix completed successfully!"