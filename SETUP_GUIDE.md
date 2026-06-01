# ExplainGen Installation & Setup Guide

## Complete Step-by-Step Setup Instructions

### System Requirements
- Windows 10/11, macOS, or Linux
- Python 3.8 or higher
- Node.js 14 or higher
- Git
- 2GB free disk space minimum

### Part 1: Prerequisites Setup

#### 1.1 Install Python
- Download from [python.org](https://www.python.org/)
- During installation, check "Add Python to PATH"
- Verify: `python --version` or `py --version`

#### 1.2 Install Node.js
- Download from [nodejs.org](https://nodejs.org/)
- Choose LTS version
- Verify: `node --version` and `npm --version`

#### 1.3 Get API Keys

**Google API Key:**
1. Go to [Google AI Studio](https://aistudio.google.com/app/apikeys)
2. Click "Get API Key"
3. Click "Create API key in new project"
4. Copy your API key

**Pinecone API Key:**
1. Sign up at [Pinecone.io](https://www.pinecone.io/)
2. Create a new project
3. Go to API Keys section
4. Copy your API key and environment

---

### Part 2: Backend Setup

#### 2.1 Navigate to Backend Directory
```bash
cd backend
```

#### 2.2 Create Virtual Environment (Recommended)

**Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**macOS/Linux:**
```bash
python3 -m venv venv
source venv/bin/activate
```

#### 2.3 Create .env File
```bash
# Windows
copy .env.example .env

# macOS/Linux
cp .env.example .env
```

#### 2.4 Configure .env File
Open `.env` and add your API keys:
```
GOOGLE_API_KEY=your_actual_google_api_key
PINECONE_API_KEY=your_actual_pinecone_api_key
PINECONE_INDEX_NAME=explaingen-index
PINECONE_ENV=us-east-1
FLASK_PORT=8000
FLASK_DEBUG=False
```

#### 2.5 Install Python Dependencies
```bash
pip install -r requirements.txt
```

Wait for all packages to install (this may take 2-3 minutes).

#### 2.6 Verify Backend Installation
```bash
python -c "import flask; import google.generativeai; import pinecone; print('✅ All dependencies installed!')"
```

#### 2.7 Start Backend Server
```bash
python app.py
```

Expected output:
```
==================================================
ExplainGen - Starting Backend Server
==================================================
Initializing services...
Initializing Embedding Manager...
Initializing Pinecone Manager...
Initializing Gemini Client...
All services initialized successfully!

Starting Flask server on port 8000...
```

**Keep this terminal open!** You'll need the backend running.

---

### Part 3: Frontend Setup

#### 3.1 Open New Terminal Window
In a new terminal/command prompt (keep the backend running in the first one)

#### 3.2 Navigate to Frontend Directory
```bash
cd frontend
```

#### 3.3 Create .env File
```bash
# Windows
copy .env.example .env

# macOS/Linux
cp .env.example .env
```

#### 3.4 Configure Frontend .env
Open `.env` and verify:
```
REACT_APP_API_URL=http://localhost:8000/api
```

#### 3.5 Install React Dependencies
```bash
npm install
```

This will take 3-5 minutes. Wait for all packages to install.

#### 3.6 Start React Development Server
```bash
npm start
```

This will automatically open your browser at `http://localhost:3000`

---

### Part 4: Verify Installation

#### 4.1 Backend Health Check
Open your browser and go to: `http://localhost:8000/api/health`

You should see:
```json
{
  "status": "healthy",
  "message": "ExplainGen API is running",
  "services": {
    "embedding_manager": true,
    "pinecone_manager": true,
    "gemini_client": true
  }
}
```

#### 4.2 Frontend Check
Frontend should automatically open at `http://localhost:3000`

You should see:
- Header: "ExplainGen"
- Status indicator showing "✅ Connected"
- Upload and Chat tabs available

#### 4.3 Test Upload
1. Click "Upload" tab
2. Drag and drop or select a PDF/text file
3. Click "Upload & Process"
4. You should see success message

---

### Part 5: First Use

#### 5.1 Upload a Test Document
1. Create or find a PDF file (e.g., study notes)
2. Go to "Upload" tab
3. Upload the file
4. Wait for processing (you'll see "✅ Upload successful!")

#### 5.2 Ask a Question
1. Go to "Chat" tab
2. Make sure "💬 Ask Question" mode is selected
3. Type a question about your uploaded material
4. Click "📤 Send"
5. Wait for the AI response

#### 5.3 Generate Summary
1. Go to "Chat" tab
2. Click "📝 Generate Summary"
3. Select summary level (Basic/Intermediate/Advanced)
4. Click "📤 Send"

#### 5.4 Generate Quiz
1. Go to "Chat" tab
2. Click "❓ Generate Quiz"
3. Set number of questions and difficulty
4. Click "📤 Send"

---

### Troubleshooting

#### Problem: Backend won't start
**Solution:**
```bash
# Make sure you're in backend directory
cd backend

# Verify .env file exists and has correct keys
cat .env

# Try reinstalling dependencies
pip install --upgrade -r requirements.txt

# Try running with explicit Python path
python app.py
```

#### Problem: "ModuleNotFoundError" when starting backend
**Solution:**
```bash
# Activate virtual environment
# Windows: venv\Scripts\activate
# macOS/Linux: source venv/bin/activate

# Reinstall all packages
pip install -r requirements.txt --force-reinstall

python app.py
```

#### Problem: Frontend can't connect to backend (Red X status)
**Solution:**
1. Verify backend is running (check terminal)
2. Verify backend is on port 8000
3. Check `.env` file in frontend folder
4. Hard refresh browser: `Ctrl+Shift+R` (or `Cmd+Shift+R` on Mac)

#### Problem: "API returned 401 error"
**Solution:**
1. Verify API keys are correct in backend/.env
2. Check if Google API key has Generative AI enabled
3. Verify Pinecone API key is valid
4. Restart backend: stop it and run `python app.py` again

#### Problem: File upload fails
**Solution:**
```bash
# Make sure data/uploads directory exists and is writable
# Windows
mkdir data\uploads
mkdir data\cache

# macOS/Linux
mkdir -p data/uploads
mkdir -p data/cache
```

#### Problem: "CORS error" in browser console
**Solution:**
1. Make sure backend is running
2. Check that frontend is connecting to `http://localhost:8000/api`
3. Restart both frontend and backend

---

### Environment Variables Reference

#### Backend (.env)
```
# Google Generative AI
GOOGLE_API_KEY=                    # Required: From Google AI Studio
PINECONE_API_KEY=                  # Required: From Pinecone
PINECONE_INDEX_NAME=explaingen-index  # Optional: Default shown
PINECONE_ENV=us-east-1            # Optional: Your Pinecone region
FLASK_PORT=8000                    # Optional: Backend port
FLASK_DEBUG=False                  # Optional: Debug mode
```

#### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:8000/api  # Backend API endpoint
```

---

### Running the Application

#### Terminal 1: Backend
```bash
cd backend
# Activate virtual environment if using one
python app.py
```

#### Terminal 2: Frontend
```bash
cd frontend
npm start
```

---

### Stopping the Application

- **Backend**: Press `Ctrl+C` in backend terminal
- **Frontend**: Press `Ctrl+C` in frontend terminal

---

### Additional Commands

#### Backend Development
```bash
# Run tests (if test suite exists)
python -m pytest

# Install new package
pip install package_name

# Freeze requirements
pip freeze > requirements.txt
```

#### Frontend Development
```bash
# Build for production
npm run build

# Run tests
npm test

# Install new package
npm install package_name
```

---

### Next Steps

1. **Read the main README.md** for API documentation
2. **Explore example usage** in the Info tab
3. **Upload your own study materials** to test the system
4. **Experiment with different modes** (Ask, Clarify, Summary, Quiz)
5. **Check the console** for any errors or helpful information

---

### Getting Help

If you encounter issues:
1. Check the "Troubleshooting" section above
2. Verify all API keys are correct
3. Make sure both backend and frontend are running
4. Check browser console for error messages
5. Check backend terminal for API errors

---

### Performance Tips

1. Start with smaller PDF files (< 5MB) for testing
2. Use appropriate chunk sizes for your content
3. Generate quizzes with 5-10 questions for faster response
4. Close other browser tabs to improve performance

---

**You're all set! Enjoy using ExplainGen! 🎓**
