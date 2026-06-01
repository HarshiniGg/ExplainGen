#!/bin/bash
# ExplainGen Startup Script for macOS/Linux

echo ""
echo "====================================="
echo "  ExplainGen - Startup Script"
echo "====================================="
echo ""

# Check if backend directory exists
if [ ! -d "backend" ]; then
    echo "ERROR: backend directory not found"
    echo "Make sure you run this script from the ExplainGen root directory"
    exit 1
fi

# Check if frontend directory exists
if [ ! -d "frontend" ]; then
    echo "ERROR: frontend directory not found"
    echo "Make sure you run this script from the ExplainGen root directory"
    exit 1
fi

# Start Backend in background
echo "[1/2] Starting Backend Server..."
echo ""
(
    cd backend
    if [ -d "venv" ]; then
        source venv/bin/activate
    fi
    echo "Starting Flask server..."
    python app.py
) &
BACKEND_PID=$!

# Wait for backend to start
echo "[+] Backend startup initiated. Waiting 5 seconds..."
sleep 5

# Start Frontend in new terminal window
echo "[2/2] Starting Frontend Server..."
echo ""

# For macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    osascript -e "tell app \"Terminal\" to do script \"cd '$PWD/frontend' && npm start\""
# For Linux
else
    gnome-terminal -- bash -c "cd '$PWD/frontend' && npm start" &
fi

# Display instructions
echo ""
echo "====================================="
echo "  ExplainGen is Starting"
echo "====================================="
echo ""
echo "Backend will be available at:"
echo "   http://localhost:8000"
echo "   http://localhost:8000/api/health"
echo ""
echo "Frontend will be available at:"
echo "   http://localhost:3000"
echo ""
echo "Keep both terminal windows open to run the application."
echo "Close either window to stop the respective server."
echo ""
echo "To stop:"
echo "   - Close the backend terminal window (or press Ctrl+C)"
echo "   - Close the frontend terminal window (or press Ctrl+C)"
echo ""
echo "Initial frontend load may take 1-2 minutes. Please wait..."
echo ""

wait $BACKEND_PID
