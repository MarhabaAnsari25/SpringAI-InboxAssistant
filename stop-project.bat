@echo off
REM Stop all running instances of the Email Management System

echo.
echo ============================================
echo   Stopping AI Email Management System
echo ============================================
echo.

echo Stopping Backend Server (Java/Maven)...
taskkill /FI "WINDOWTITLE eq Email Writer Backend*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Backend*" /T /F >nul 2>&1

echo Stopping Frontend Application (Node/Vite)...
taskkill /FI "WINDOWTITLE eq Email Writer Frontend*" /T /F >nul 2>&1
taskkill /FI "WINDOWTITLE eq Frontend*" /T /F >nul 2>&1

REM Also kill any Java processes running Spring Boot
echo Cleaning up Java processes...
for /f "tokens=2" %%a in ('tasklist ^| findstr /i "java.exe"') do (
    taskkill /PID %%a /F >nul 2>&1
)

REM Kill Node processes running on port 5173
echo Cleaning up Node processes...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :5173') do (
    taskkill /PID %%a /F >nul 2>&1
)

REM Kill processes on port 9191
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :9191') do (
    taskkill /PID %%a /F >nul 2>&1
)

echo.
echo ============================================
echo   All services stopped!
echo ============================================
echo.
pause
