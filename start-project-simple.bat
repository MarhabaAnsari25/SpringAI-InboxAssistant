@echo off
REM Simple launcher - starts backend and frontend

echo Starting AI Email Management System...
echo.

REM Set API Key
set GEMINI_KEY=PasteYourGeminiKeyCodeHere

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
