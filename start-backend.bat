@echo off
REM Start Backend Script for Windows

echo =========================================
echo Starting Email Writer Backend Server
echo =========================================
echo.

REM Check if environment variables are set
if "%GEMINI_KEY%"=="" (
    echo WARNING: GEMINI_KEY environment variable is not set!
    echo.
    echo Please set it using:
    echo   set GEMINI_KEY=your-api-key-here
    echo.
    echo Or for PowerShell:
    echo   $env:GEMINI_KEY='your-api-key-here'
    echo.
    pause
)

echo Starting Spring Boot application...
echo Server will be available at: http://localhost:9191
echo.

mvnw.cmd spring-boot:run
