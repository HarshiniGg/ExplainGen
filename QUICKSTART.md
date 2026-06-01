# Quick Start Guide for ExplainGen

## 🚀 5-Minute Quick Start

### Option 1: Automated Startup (Recommended)

#### Windows Users:
1. Open Command Prompt in the ExplainGen folder
2. Run: `startup.bat`
3. Wait for both terminals to open
4. Open browser to `http://localhost:3000`

#### macOS/Linux Users:
1. Open Terminal in the ExplainGen folder
2. Run: `chmod +x startup.sh` (first time only)
3. Run: `./startup.sh`
4. Wait for both terminals to open
5. Open browser to `http://localhost:3000`

### Option 2: Manual Startup

#### Terminal 1 - Backend:
```bash
cd backend
pip install -r requirements.txt
python app.py
```

#### Terminal 2 - Frontend:
```bash
cd frontend
npm install
npm start
```

---

## ⚙️ Pre-Flight Checklist

Before starting, ensure:

- [ ] Python 3.8+ installed: `python --version`
- [ ] Node.js 14+ installed: `node --version`
- [ ] `.env` files created in both `backend` and `frontend` folders
- [ ] Google API Key added to `backend/.env`
- [ ] Pinecone API Key added to `backend/.env`
- [ ] `data/uploads/` folder exists (created during first run)

### Create .env files quickly:

**Backend:**
```bash
cd backend
copy .env.example .env
# Edit .env and add your API keys
```

**Frontend:**
```bash
cd frontend
copy .env.example .env
```

---

## 🎯 First Steps After Startup

1. **Verify Backend**: Visit `http://localhost:8000/api/health`
   - Should show green status and "healthy"

2. **Check Frontend**: Visit `http://localhost:3000`
   - Should show "ExplainGen" interface with "✅ Connected"

3. **Upload a Document**:
   - Click "Upload" tab
   - Drag/drop or select a PDF or text file
   - Click "Upload & Process"

4. **Ask a Question**:
   - Click "Chat" tab
   - Enter your question
   - Click "Send"
   - See the AI response with explanation

---

## 📊 Performance Expectations

| Operation | Time |
|-----------|------|
| Backend startup | 5-10 seconds |
| Frontend startup | 30-60 seconds |
| File upload (5MB PDF) | 10-30 seconds |
| Ask question | 5-15 seconds |
| Generate summary | 10-20 seconds |
| Generate quiz | 15-30 seconds |

---

## 🛑 Stopping the Application

### Windows:
- Close both terminal windows

### macOS/Linux:
- Press `Ctrl+C` in each terminal

---

## ❓ Quick Troubleshooting

### Backend won't start
```bash
cd backend
pip install --upgrade -r requirements.txt
python app.py
```

### Frontend won't connect
```bash
# Hard refresh browser: Ctrl+Shift+R (Windows) or Cmd+Shift+R (Mac)
# Verify backend is running on port 8000
# Check frontend/.env has correct API_URL
```

### "Module not found" error
```bash
cd backend
pip install -r requirements.txt --force-reinstall
```

### Port already in use
```bash
# Change port in backend/.env:
FLASK_PORT=8001  # Change to different port

# Then update frontend/.env:
REACT_APP_API_URL=http://localhost:8001/api
```

---

## 📚 Learn More

- See `README.md` for detailed features and architecture
- See `SETUP_GUIDE.md` for complete installation steps
- See `API_DOCUMENTATION.md` for API details
- Check `/backend/app.py` for available endpoints

---

## 🎓 Example Usage

### 1. Upload Study Material
```bash
curl -X POST -F "file=@notes.pdf" http://localhost:8000/api/upload
```

### 2. Ask Question
```bash
curl -X POST http://localhost:8000/api/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "What are the main topics covered?"}'
```

### 3. Generate Quiz
```bash
curl -X POST http://localhost:8000/api/quiz \
  -H "Content-Type: application/json" \
  -d '{"num_questions": 5, "difficulty": "medium"}'
```

---

## 💡 Pro Tips

1. **Save your API keys**: Store Google and Pinecone keys safely
2. **Start with small files**: Test with small PDFs first
3. **Use Clear Questions**: More specific questions get better answers
4. **Check the browser console**: For detailed error information
5. **Monitor backend terminal**: Shows what's happening behind the scenes

---

## 🆘 Getting Help

1. Check the troubleshooting sections in documentation
2. Verify all API keys are correct
3. Make sure both servers are running
4. Check browser console for errors
5. Review backend terminal for API errors

---

## ✅ You're Ready!

Your ExplainGen application is ready to use! 

**Start with the upload tab and explore the features.** 🎓

---

**Happy Learning!**
