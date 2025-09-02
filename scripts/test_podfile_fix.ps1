# PowerShell script to test the Podfile fix locally

Write-Host "Testing Podfile fix locally..."

# Navigate to the iOS directory
Set-Location -Path "ios"

# Remove any existing Generated.xcconfig
if (Test-Path "Flutter\Generated.xcconfig") {
    Write-Host "Removing existing Generated.xcconfig..."
    Remove-Item "Flutter\Generated.xcconfig" -Force
}

# Go back to the root directory
Set-Location -Path ".."

# Run flutter precache to regenerate the file
Write-Host "Regenerating Generated.xcconfig..."
flutter precache --ios

# Verify the file was created
if (Test-Path "ios\Flutter\Generated.xcconfig") {
    Write-Host "Generated.xcconfig successfully regenerated!"
    Write-Host "Contents:"
    Get-Content "ios\Flutter\Generated.xcconfig"
    
    # Test if the Podfile can be parsed
    Write-Host "Testing Podfile parsing..."
    Set-Location -Path "ios"
    # This will test if the Podfile can be parsed without errors
    $result = pod install --dry-run 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "SUCCESS: Podfile parsed correctly!" -ForegroundColor Green
    } else {
        Write-Host "ERROR: Podfile parsing failed!" -ForegroundColor Red
        Write-Host $result
    }
    Set-Location -Path ".."
} else {
    Write-Host "ERROR: Generated.xcconfig was not created!" -ForegroundColor Red
    exit 1
}

Write-Host "Test completed successfully!" -ForegroundColor Green