@echo off
REM ExplainGen Startup Script for Windows
REM This script starts both the backend and frontend servers

title ExplainGen Startup
color 0A

echo.
echo =====================================
echo   ExplainGen - Startup Script
echo =====================================
echo.

REM Check if backend directory exists
if not exist "backend" (
    echo ERROR: backend directory not found
    echo Make sure you run this script from the ExplainGen root directory
    pause
    exit /b 1
)

REM Check if frontend directory exists
if not exist "frontend" (
    echo ERROR: frontend directory not found
    echo Make sure you run this script from the ExplainGen root directory
    pause
    exit /b 1
)

REM Start Backend
echo [1/2] Starting Backend Server...
echo.
start cmd /k "cd backend & echo Activating virtual environment... & if exist venv\Scripts\activate.bat venv\Scripts\activate.bat & echo Starting Flask server... & python app.py"

REM Wait for backend to start
echo.
echo [+] Backend startup initiated. Waiting 5 seconds...
timeout /t 5 /nobreak

REM Start Frontend
echo [2/2] Starting Frontend Server...
echo.
start cmd /k "cd frontend & echo Installing dependencies if needed... & if not exist node_modules npm install & echo Starting React development server... & npm start"

REM Display instructions
echo.
echo =====================================
echo   ExplainGen is Starting
echo =====================================
echo.
echo Backend will be available at:
echo   http://localhost:8000
echo   http://localhost:8000/api/health
echo.
echo Frontend will be available at:
echo   http://localhost:3000
echo.
echo Keep both terminal windows open to run the application.
echo Close either window to stop the respective server.
echo.
echo To stop:
echo   - Close the backend terminal window (or press Ctrl+C)
echo   - Close the frontend terminal window (or press Ctrl+C)
echo.
echo Initial frontend load may take 1-2 minutes. Please wait...
echo.
pause
