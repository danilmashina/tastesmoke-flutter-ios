# PowerShell script для проверки зависимостей Flutter iOS проекта
# Проверяет все необходимые инструменты для сборки

Write-Host "=== Проверка зависимостей для Flutter iOS разработки ===" -ForegroundColor Green

$errors = 0

# Проверка Flutter
Write-Host "`n--- Проверка Flutter ---" -ForegroundColor Yellow
try {
    $flutterVersion = flutter --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Flutter установлен" -ForegroundColor Green
        flutter --version | Select-String "Flutter" | ForEach-Object { Write-Host "   $($_.ToString())" -ForegroundColor Gray }
    } else {
        Write-Host "❌ Flutter не найден" -ForegroundColor Red
        $errors++
    }
} catch {
    Write-Host "❌ Flutter не найден" -ForegroundColor Red
    $errors++
}

# Проверка CocoaPods
Write-Host "`n--- Проверка CocoaPods ---" -ForegroundColor Yellow
try {
    $podVersion = pod --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ CocoaPods установлен: $podVersion" -ForegroundColor Green
    } else {
        Write-Host "❌ CocoaPods не найден" -ForegroundColor Red
        Write-Host "   Установка: gem install cocoapods" -ForegroundColor Gray
        $errors++
    }
} catch {
    Write-Host "❌ CocoaPods не найден" -ForegroundColor Red
    $errors++
}

# Проверка Xcode (если на macOS через WSL или Remote)
Write-Host "`n--- Проверка среды разработки ---" -ForegroundColor Yellow
if (Test-Path "ios\Runner.xcodeproj") {
    Write-Host "✅ iOS проект найден" -ForegroundColor Green
} else {
    Write-Host "❌ iOS проект не найден" -ForegroundColor Red
    $errors++
}

# Проверка pubspec.yaml
Write-Host "`n--- Проверка конфигурации проекта ---" -ForegroundColor Yellow
if (Test-Path "pubspec.yaml") {
    Write-Host "✅ pubspec.yaml найден" -ForegroundColor Green
    
    # Проверка Firebase зависимостей
    $pubspecContent = Get-Content "pubspec.yaml" -Raw
    if ($pubspecContent -match "firebase_core") {
        Write-Host "✅ Firebase зависимости настроены" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Firebase зависимости не найдены" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ pubspec.yaml не найден" -ForegroundColor Red
    $errors++
}

# Проверка Firebase конфигурации
Write-Host "`n--- Проверка Firebase конфигурации ---" -ForegroundColor Yellow
if (Test-Path "ios\Runner\GoogleService-Info.plist") {
    Write-Host "✅ GoogleService-Info.plist найден" -ForegroundColor Green
} else {
    Write-Host "⚠️  GoogleService-Info.plist не найден в ios/Runner/" -ForegroundColor Yellow
}

if (Test-Path "lib\firebase_options.dart") {
    Write-Host "✅ firebase_options.dart найден" -ForegroundColor Green
} else {
    Write-Host "⚠️  firebase_options.dart не найден" -ForegroundColor Yellow
}

# Проверка Podfile
Write-Host "`n--- Проверка Podfile ---" -ForegroundColor Yellow
if (Test-Path "ios\Podfile") {
    Write-Host "✅ Podfile найден" -ForegroundColor Green
    
    $podfileContent = Get-Content "ios\Podfile" -Raw
    if ($podfileContent -match "platform :ios, '13.0'") {
        Write-Host "✅ iOS deployment target 13.0+" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Проверьте iOS deployment target в Podfile" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Podfile не найден" -ForegroundColor Red
    $errors++
}

# Итоговый результат
Write-Host "`n=== Результат проверки ===" -ForegroundColor Green
if ($errors -eq 0) {
    Write-Host "✅ Все зависимости готовы для сборки!" -ForegroundColor Green
    Write-Host "Можно запускать: .\scripts\full_clean_rebuild.ps1" -ForegroundColor Cyan
} else {
    Write-Host "❌ Найдено $errors ошибок. Исправьте их перед сборкой." -ForegroundColor Red
    exit 1
}

# Дополнительные команды
Write-Host "`n=== Полезные команды ===" -ForegroundColor Green
Write-Host "Полная очистка:    .\scripts\full_clean_rebuild.ps1" -ForegroundColor Cyan
Write-Host "Проверка Flutter:  flutter doctor" -ForegroundColor Cyan
Write-Host "Обновление pods:   cd ios; pod install --repo-update" -ForegroundColor Cyan
Write-Host "Сборка iOS:        flutter build ios --release --no-codesign" -ForegroundColor Cyan