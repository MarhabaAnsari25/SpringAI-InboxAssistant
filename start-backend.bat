@echo off
REM Start Backend Script for Windows

echo =========================================
echo Starting Email Writer Backend Server
echo =========================================
echo.

REM Load GEMINI_KEY from .env file if not already set
if "%GEMINI_KEY%"=="" (
    if exist ".env" (
        for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
            if /i "%%A"=="GEMINI_KEY" set GEMINI_KEY=%%B
        )
    )
)

REM Check if key was loaded
if "%GEMINI_KEY%"=="" (
    echo ERROR: GEMINI_KEY is not set!
    echo.
    echo Please add your key to the .env file:
    echo   GEMINI_KEY=your-api-key-here
    echo.
    pause
    exit /b 1
)

echo API Key: Loaded
echo Starting Spring Boot application...
echo Server will be available at: http://localhost:9191
echo.

mvnw.cmd spring-boot:run
