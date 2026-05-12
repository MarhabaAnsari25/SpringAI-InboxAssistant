@echo off
REM Simple launcher - starts backend and frontend

echo Starting AI Email Management System...
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

echo API Key: Loaded from .env
echo.

REM Start Backend
echo [1/2] Starting Backend Server...
start "Backend - Port 9191" cmd /k "set GEMINI_KEY=%GEMINI_KEY% && mvnw.cmd spring-boot:run"

REM Wait for backend
timeout /t 20 /nobreak >nul

REM Start Frontend
echo [2/2] Starting Frontend Application...
start "Frontend - Port 5173" cmd /k "cd email-writer-react && npm run dev"

echo.
echo Done! Opening browser...
timeout /t 10 /nobreak >nul
start http://localhost:5173

echo.
echo Application is running!
echo Backend: http://localhost:9191
echo Frontend: http://localhost:5173
echo.
pause
