@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo   VoiceAid - Flutter Environment & App Setup
echo ========================================================

where flutter >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] Flutter is not found in your PATH.
    echo Installing Flutter via winget...
    winget install --id Google.Flutter -e --accept-package-agreements --accept-source-agreements
    echo.
    echo Please restart your terminal after installation and run this script again.
    pause
    exit /b
)

echo [✓] Flutter detected.
cd voiceaid

echo [*] Generating platform runner files (Android, Windows, Web)...
flutter create --platforms=android,windows,web --project-name voiceaid --org in.voiceaid .

echo [*] Fetching Flutter dependencies...
flutter pub get

echo [*] Running automated tests...
flutter test

echo [*] Starting VoiceAid on Chrome...
flutter run -d chrome

pause

