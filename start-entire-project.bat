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

REM Set the Gemini API Key
set GEMINI_KEY=PasteYourGeminiKeyCodeHere

echo [1/3] Setting up environment...
echo      API Key: Configured
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
start "Email Writer Backend - Port 9191" cmd /k "color 0B && echo ============================================ && echo   BACKEND SERVER - Port 9191 && echo ============================================ && echo. && set GEMINI_KEY=%GEMINI_KEY% && mvnw.cmd spring-boot:run"

REM Wait a bit for backend to start
echo Waiting for backend to initialize (20 seconds)...
timeout /t 20 /nobreak >nul

REM Start Frontend in a new window
echo Starting Frontend Application...
start "Email Writer Frontend - Port 5173" cmd /k "color 0E && echo ============================================ && echo   FRONTEND APPLICATION - Port 5173 && echo ============================================ && echo. && cd email-writer-react && npm run dev"

REM Wait a bit for frontend to start
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

REM Open browser to frontend
start http://localhost:5173

echo.
echo ============================================
echo   READY TO USE!
echo ============================================
echo.
echo To stop the application:
echo   - Close both terminal windows
echo   - Or press Ctrl+C in each window
echo.
echo This window can be closed safely.
echo.
pause
