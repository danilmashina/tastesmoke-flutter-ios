# PowerShell script for full clean rebuild on Windows
# Соответствует стратегии исправления iOS build errors

Write-Host "=== Полная очистка среды Flutter iOS ===" -ForegroundColor Green

# Очистка iOS pods
Write-Host "--- Деинтеграция CocoaPods ---" -ForegroundColor Yellow
Set-Location ios
pod deintegrate
Set-Location ..

# Очистка Flutter
Write-Host "--- Очистка Flutter ---" -ForegroundColor Yellow
flutter clean

# Удаление временных файлов
Write-Host "--- Удаление временных файлов ---" -ForegroundColor Yellow
if (Test-Path "ios\Pods") { Remove-Item -Recurse -Force "ios\Pods" }
if (Test-Path "ios\Podfile.lock") { Remove-Item -Force "ios\Podfile.lock" }
if (Test-Path "ios\.symlinks") { Remove-Item -Recurse -Force "ios\.symlinks" }
if (Test-Path ".dart_tool") { Remove-Item -Recurse -Force ".dart_tool" }

Write-Host "=== Повторная инициализация ===" -ForegroundColor Green

# Получение Flutter зависимостей
Write-Host "--- Flutter pub get ---" -ForegroundColor Yellow
flutter pub get

# Установка pods
Write-Host "--- Установка CocoaPods ---" -ForegroundColor Yellow
Set-Location ios
pod install --repo-update
Set-Location ..

Write-Host "=== Готово! Среда очищена и переинициализирована ===" -ForegroundColor Green
Write-Host "Теперь можно запускать: flutter build ios --release --no-codesign" -ForegroundColor Cyan