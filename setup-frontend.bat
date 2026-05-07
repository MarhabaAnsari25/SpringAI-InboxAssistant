@echo off
REM Setup Frontend - Install Dependencies

echo.
echo ============================================
echo   Setting Up Frontend Application
echo ============================================
echo.

cd email-writer-react

echo Installing Node.js dependencies...
echo This may take a few minutes...
echo.

call npm install

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo   Frontend Setup Complete!
    echo ============================================
    echo.
    echo You can now run: start-entire-project.bat
    echo.
) else (
    echo.
    echo ============================================
    echo   ERROR: Setup Failed!
    echo ============================================
    echo.
    echo Please check your internet connection
    echo and make sure Node.js is installed.
    echo.
)

cd ..
pause
