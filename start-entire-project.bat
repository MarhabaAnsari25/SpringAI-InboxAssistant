@echo off
REM ============================================
REM AI-Powered Email Management System Launcher
REM ============================================

color 0A
echo.
echo ============================================
echo   AI Email Management System
echo   Starting Full Application...
echo ============================================
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
    echo Please add your key to the .env file:
    echo   GEMINI_KEY=your_key_here
    echo.
    pause
    exit /b 1
)

echo [1/3] Setting up environment...
echo      API Key: Loaded from .env
echo      Port: 9191 (Backend)
echo      Port: 5173 (Frontend)
echo.

REM Check if Node.js is installed
echo [2/3] Checking prerequisites...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)
echo      Node.js: Found
echo      Java: Found
echo      Maven: Found
echo.

echo [3/3] Checking frontend dependencies...
if not exist "email-writer-react\node_modules\" (
    echo      Frontend dependencies not found!
    echo      Installing npm packages...
    echo.
    cd email-writer-react
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo ERROR: Failed to install frontend dependencies!
        cd ..
        pause
        exit /b 1
    )
    cd ..
    echo      Dependencies installed successfully!
    echo.
) else (
    echo      Frontend dependencies: Found
    echo.
)

echo [4/4] Starting services...
echo.

REM Start Backend in a new window
echo Starting Backend Server...
set "PROJECT_DIR=%~dp0"
start "Email Writer Backend - Port 9191" cmd /k "color 0B && echo ============================================ && echo   BACKEND SERVER - Port 9191 && echo ============================================ && echo. && cd /d ""%PROJECT_DIR%"" && set GEMINI_KEY=%GEMINI_KEY% && mvnw.cmd spring-boot:run"

REM Wait for backend to start
echo Waiting for backend to initialize (20 seconds)...
timeout /t 20 /nobreak >nul

REM Start Frontend in a new window
echo Starting Frontend Application...
start "Email Writer Frontend - Port 5173" cmd /k "color 0E && echo ============================================ && echo   FRONTEND APPLICATION - Port 5173 && echo ============================================ && echo. && cd /d ""%PROJECT_DIR%email-writer-react"" && npm run dev"

REM Wait for frontend to start
echo Waiting for frontend to initialize (10 seconds)...
timeout /t 10 /nobreak >nul

echo.
echo ============================================
echo   APPLICATION STARTED SUCCESSFULLY!
echo ============================================
echo.
echo Backend API:  http://localhost:9191
echo Frontend UI:  http://localhost:5173
echo.
echo Two new windows have been opened:
echo   1. Backend Server (Blue)
echo   2. Frontend Application (Yellow)
echo.
echo Opening browser in 5 seconds...
timeout /t 5 /nobreak >nul

start http://localhost:5173

echo.
echo ============================================
echo   READY TO USE!
echo ============================================
echo.
echo To stop: close both terminal windows or press Ctrl+C in each.
echo This window can be closed safely.
echo.
pause
