# ExplainGen - Explainable Generative AI for Personalized Learning

An intelligent educational assistant that generates study materials, quiz questions, concept summaries and explains the logic behind answers, enabling students and teachers to understand reasoning and improve learning outcomes.

## 🌟 Features

✅ **Document Upload**: Upload PDFs and text files for analysis
✅ **Intelligent Q&A**: Ask questions about uploaded materials with detailed explanations
✅ **Content Summarization**: Generate summaries at different difficulty levels (basic, intermediate, advanced)
✅ **Quiz Generation**: Create practice quizzes with multiple difficulty levels
✅ **Concept Clarification**: Get in-depth explanations of specific concepts
✅ **Explainability**: Every answer includes reasoning and step-by-step explanations with clearly formatted sections (Answer, Explanation, Key Points)
✅ **Source Attribution**: Track which documents contributed to each answer
✅ **Professional UI**: Modern interface with logo, responsive design, and optimized text formatting
✅ **Real-time Status**: API health indicator showing connection status
✅ **Multi-mode Chat**: Switch between different conversation modes seamlessly

## 🏗️ Architecture

ExplainGen uses a **Retrieval-Augmented Generation (RAG)** pipeline with:

- **Frontend**: React.js 18.2.0 with modern UI/UX and responsive design
- **Backend**: Python Flask 3.0.0 with RAG pipeline and semantic search
- **LLM**: Google Gemini API (gemini-2.5-flash) for intelligent responses
- **Vector DB**: Pinecone (dense index, 768 dimensions) for semantic search and vector storage
- **Embeddings**: Google Generative AI embeddings (768-dimensional) for semantic representation
- **Retry Logic**: Tenacity library with exponential backoff for API resilience

### Core Pipeline (9-Step RAG Process)

```
1. Document Upload (PDF/TXT/MD files - max 50MB)
    ↓
2. Text Extraction & Parsing (pypdf for PDFs)
    ↓
3. Text Chunking (recursive splitting with overlap)
    ↓
4. Embedding Generation (Google Generative AI embeddings)
    ↓
5. Vector Storage (Pinecone dense index with 768 dimensions)
    ↓
6. Query Processing & Semantic Search (cosine similarity)
    ↓
7. Context Assembly (top-k relevant chunks retrieval)
    ↓
8. Prompt Enhancement & LLM Generation (Gemini-2.5-flash with structured prompts)
    ↓
9. Structured Response & Display (with Answer, Explanation, Key Points sections)
```

## 📋 Project Structure

```
ExplainGen/
├── backend/
│   ├── app.py                      # Main Flask application
│   ├── requirements.txt            # Python dependencies
│   ├── .env.example               # Environment variables template
│   │
│   ├── routes/
│   │   ├── upload.py              # File upload endpoint
│   │   ├── ask.py                 # Question answering endpoint
│   │   ├── summary.py             # Summary generation endpoint
│   │   └── quiz.py                # Quiz generation endpoint
│   │
│   └── utils/
│       ├── extractor.py           # PDF/text extraction
│       ├── text_splitter.py       # Text chunking
│       ├── embeddings.py          # Embedding generation
│       ├── gemini_client.py       # Gemini API client
│       └── pinecone_manager.py    # Pinecone vector DB manager
│
├── frontend/
│   ├── package.json               # React dependencies (React 18.2.0)
│   ├── .env.example              # Frontend env variables
│   ├── public/
│   │   ├── index.html            # Main HTML file with favicon
│   │   ├── logo.png              # ExplainGen logo (displayed in header)
│   │   └── manifest.json         # PWA manifest
│   │
│   └── src/
│       ├── App.jsx               # Main App component with header & logo
│       ├── App.css               # Main styles (responsive, header-logo-section)
│       ├── api.js                # API integration
│       ├── index.jsx             # React entry point
│       ├── index.css             # Global styles
│       │
│       ├── components/
│       │   ├── FileUploader.jsx  # File upload component (drag-drop support)
│       │   ├── ChatBox.jsx       # Chat interface with multi-mode support
│       │   └── ResponseDisplay.jsx # Response display with section parsing
│       │
│       └── styles/
│           ├── FileUploader.css
│           ├── ChatBox.css       # Includes white-space: pre-wrap for formatting
│           └── ResponseDisplay.css # Enhanced spacing & line-height (2.0)
│
├── data/
│   ├── uploads/                   # Uploaded files directory
│   └── cache/                     # Cache directory
│
└── README.md                       # This file
```

## 🚀 Getting Started

### Prerequisites

- Python 3.8+
- Node.js 14+ (with npm)
- Google API Key (for Gemini API and Embeddings)
- Pinecone Account with dense vector index (768 dimensions)
- Git
- 50MB+ free disk space for uploads

### Step 1: Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Create a `.env` file (copy from `.env.example`):
```bash
cp .env.example .env
```

3. Edit `.env` and add your API keys:
```
GOOGLE_API_KEY=your_google_api_key_here
PINECONE_API_KEY=your_pinecone_api_key_here
PINECONE_INDEX_NAME=explaingen-index
PINECONE_ENV=us-east-1
FLASK_PORT=8000
FLASK_DEBUG=False
```

**Important**: 
- Ensure your Pinecone index is created as a **DENSE** index with **768 dimensions** (matches Google embeddings)
- Use cosine similarity metric
- Your Google API key must have access to both Gemini and Generative AI Embeddings APIs

4. Install Python dependencies:
```bash
pip install -r requirements.txt
```

**Key packages:**
- Flask 3.0.0 - Web framework
- pypdf 6.2.0 - PDF extraction
- pinecone 5.0.1 - Vector database client
- google-generativeai - Gemini API and embeddings
- tenacity - Retry logic with exponential backoff
- Flask-CORS - Cross-origin resource sharing

5. Start the Flask server:
```bash
python app.py
```

The backend will be available at `http://localhost:8000`

### Step 2: Frontend Setup

1. Navigate to frontend directory:
```bash
cd frontend
```

2. Create a `.env` file:
```bash
cp .env.example .env
```

3. Edit `.env` file:
```
REACT_APP_API_URL=http://localhost:8000/api
```

4. Install dependencies:
```bash
npm install
```

5. Start the React development server:
```bash
npm start
```

The frontend will open automatically at `http://localhost:3000`

## 📚 API Endpoints (11 Total)

### Upload Routes (3 endpoints)
- **POST** `/api/upload` - Upload and process a document file
  - Form data: `file` (PDF, TXT, or MD file, max 50MB)
  - Returns: Document ID, filename, status, chunks count
  
- **GET** `/api/documents` - List all uploaded documents
  - Returns: Array of document metadata
  
- **DELETE** `/api/documents/<document_id>` - Delete a document and its vectors
  - Returns: Success status

### Question Answering (2 endpoints)
- **POST** `/api/ask` - Ask a question about uploaded materials with semantic search
  - Body: `{ "question": "Your question here" }`
  - Returns: Answer with explanation, key points, and source attribution
  
- **POST** `/api/clarify` - Get detailed explanation of a specific concept
  - Body: `{ "concept": "Concept name" }`
  - Returns: Detailed explanation with examples and key points

### Content Generation (4 endpoints)
- **POST** `/api/summary` - Generate overall summary of all uploaded documents
  - Body: `{ "level": "basic|intermediate|advanced" }`
  - Returns: Structured summary with main points and key takeaways
  
- **POST** `/api/summary-topic` - Generate topic-specific summary
  - Body: `{ "topic": "Topic name", "level": "basic|intermediate|advanced" }`
  - Returns: Topic-focused summary
  
- **POST** `/api/quiz` - Generate general quiz from documents
  - Body: `{ "num_questions": 5, "difficulty": "easy|medium|hard" }`
  - Returns: Array of quiz questions with options and explanations
  
- **POST** `/api/quiz-topic` - Generate topic-specific quiz
  - Body: `{ "topic": "Topic name", "num_questions": 5, "difficulty": "easy|medium|hard" }`
  - Returns: Topic-focused quiz questions

### System & Utility (2 endpoints)
- **GET** `/api/health` - Check API health status
  - Returns: `{ "status": "healthy", "timestamp": "...", "version": "..." }`
  
- **GET** `/api/info` - Get API information and capabilities
  - Returns: API version, description, and available models

## 🔑 API Key & Index Setup Guide

### Google API Key (Gemini & Embeddings)
1. Go to [Google AI Studio](https://aistudio.google.com/app/apikeys)
2. Click "Create API Key" (or "Get API Key" if available)
3. Copy the generated API key
4. Add to backend `.env` file: `GOOGLE_API_KEY=your_key_here`
5. Verify permissions include:
   - Gemini API (for `gemini-2.5-flash` model)
   - Generative AI Embeddings API (for text embedding)

### Pinecone Setup (Important!)
1. Sign up at [Pinecone](https://www.pinecone.io/)
2. Create a new project
3. **Create a DENSE vector index** with these specifications:
   - **Name**: `explaingen-index` (or your chosen name)
   - **Dimensions**: `768` (matches Google embeddings)
   - **Metric**: `cosine`
   - **Index Type**: `Dense` (NOT sparse)
4. Get your API Key from the dashboard
5. Note your environment region (e.g., `us-east-1`)
6. Add to backend `.env`:
   ```
   PINECONE_API_KEY=your_api_key
   PINECONE_INDEX_NAME=explaingen-index
   PINECONE_ENV=us-east-1
   ```

**⚠️ Common Issue**: If your index is sparse instead of dense, you'll get dimension mismatch errors. Always create a **DENSE** index.

## 💡 Usage Examples

### Example 1: Upload a Document
```bash
curl -X POST -F "file=@study_notes.pdf" http://localhost:8000/api/upload
```

**Response:**
```json
{
  "status": "success",
  "document_id": "550e8400-e29b-41d4-a716-446655440000",
  "filename": "study_notes.pdf",
  "message": "File processed and stored successfully",
  "chunks_created": 15
}
```

### Example 2: Ask a Question
```bash
curl -X POST http://localhost:8000/api/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "What is photosynthesis?"}'
```

**Response:**
```json
{
  "answer": "ANSWER:\nPhotosynthesis is the process...",
  "explanation": "EXPLANATION:\nPhotosynthesis occurs in chloroplasts...",
  "key_points": "KEY POINTS:\n- Requires light energy\n- Produces glucose and oxygen",
  "sources": ["document_id_1"]
}
```

### Example 3: Generate Summary
```bash
curl -X POST http://localhost:8000/api/summary \
  -H "Content-Type: application/json" \
  -d '{"level": "intermediate"}'
```

### Example 4: Generate Quiz
```bash
curl -X POST http://localhost:8000/api/quiz \
  -H "Content-Type: application/json" \
  -d '{"num_questions": 5, "difficulty": "medium"}'
```

**Response includes:**
- Multiple choice questions
- Answer options (A, B, C, D)
- Correct answers
- Explanations for each question

## 🎨 Frontend Usage

### Main Interface Features

1. **Header Section**
   - ExplainGen logo with branding
   - Real-time API connection status indicator
   - Responsive design for all screen sizes

2. **Upload Tab** 📤
   - Drag-and-drop file upload area
   - Supports: PDF, TXT, MD files
   - Maximum file size: 50MB
   - Shows upload progress and status
   - Displays list of uploaded documents

3. **Chat Tab** 💬
   - Multi-mode conversation interface
   - Switch between operation modes using buttons:
     - **Ask Question**: Ask specific questions about uploaded materials
     - **Clarify Concept**: Get detailed explanations of concepts
     - **Generate Summary**: Create summaries at difficulty levels (basic/intermediate/advanced)
     - **Generate Quiz**: Create practice quizzes (easy/medium/hard)
   - View chat history with clear formatting
   - Real-time response generation

4. **Response Display**
   - **Structured Sections**:
     - **ANSWER**: Direct response to your query
     - **EXPLANATION**: Detailed reasoning and context
     - **KEY POINTS**: Bullet-point summary of main ideas
     - **MAIN SUMMARY**: Overview of content (for summaries)
     - **KEY TAKEAWAYS**: Important concepts to remember
   - Optimized text formatting with improved spacing and line-height
   - Scrollable content area

### How Response Formatting Works

Responses are automatically parsed into clear, readable sections:
- Each section is clearly labeled and separated
- Multi-line formatting preserves structure and readability
- Quiz questions display with numbered options and explanations
- Line-height set to 2.0 for comfortable reading

## 🔧 Configuration

### Backend Configuration (`backend/.env`)
- `GOOGLE_API_KEY`: Your Google API key
- `PINECONE_API_KEY`: Your Pinecone API key
- `PINECONE_INDEX_NAME`: Name of your Pinecone index
- `PINECONE_ENV`: Pinecone environment (region)
- `FLASK_PORT`: Port for Flask server (default: 8000)
- `FLASK_DEBUG`: Debug mode (default: False)

### Frontend Configuration (`frontend/.env`)
- `REACT_APP_API_URL`: Backend API URL (default: http://localhost:8000/api)

## 📊 Supported File Formats

- **PDF** (.pdf)
- **Text** (.txt)
- **Markdown** (.md)

Maximum file size: 50MB

## 🧠 How Explainability Works

ExplainGen ensures explainability through a structured approach:

1. **Context Retrieval**
   - Uploads documents and splits into semantic chunks
   - Stores exact text segments with document references
   - Enables source attribution for all answers

2. **Semantic Search** 
   - Converts queries and documents into 768-dimensional embeddings
   - Uses cosine similarity to find most relevant chunks
   - Returns top-k results for context assembly

3. **Prompt Structuring**
   - Uses Google Gemini (`gemini-2.5-flash`) with engineered prompts
   - Enforces specific output structure with section markers
   - Ensures consistent formatting across all response types

4. **Structured Responses**
   - **ANSWER section**: Direct, concise answer to the query
   - **EXPLANATION section**: Detailed reasoning with context
   - **KEY POINTS section**: Bullet-point summary of critical information
   - **Source Attribution**: References which documents provided the information

5. **Confidence through Transparency**
   - Shows exact document chunks used for retrieval
   - Displays relevance scores for context
   - Provides step-by-step reasoning in explanations
   - Allows verification of AI-generated content

## 🛠️ Troubleshooting

### Backend won't start
- **Ensure all dependencies are installed**: 
  ```bash
  pip install -r requirements.txt
  ```
  Verify correct packages: Flask 3.0.0, pypdf (not PyPDF2), pinecone 5.0.1
- **Check `.env` file exists** with valid API keys
- **Verify port 8000 is not in use**: 
  ```bash
  netstat -ano | findstr :8000  # Windows
  ```
- **Check Python version**: Requires Python 3.8+

### Frontend can't connect to backend
- **Ensure backend is running**: 
  ```
  http://localhost:8000/api/health should return 200
  ```
- **Check `.env` file**: Verify `REACT_APP_API_URL=http://localhost:8000/api`
- **Check browser console** (F12) for CORS or connection errors
- **Rebuild frontend**: 
  ```bash
  rm -rf node_modules package-lock.json
  npm install
  npm start
  ```

### API returns 401 Unauthorized errors
- **Verify Google API Key**:
  - Must have Gemini API enabled
  - Must have Generative AI Embeddings enabled
  - Check key hasn't expired or been revoked
- **Verify Pinecone API Key**:
  - Check key is correct and active
  - Verify environment (region) matches `.env`
  - Ensure API key has permissions for the index

### Pinecone dimension mismatch error
- **CRITICAL**: Your Pinecone index must be **DENSE** with **768 dimensions**
- Sparse indices won't work with this setup
- Solution: Delete current index and create new dense index
  ```
  - Index type: Dense (NOT Sparse or serverless)
  - Dimensions: 768
  - Metric: cosine
  ```

### "Invalid model name" or model not found errors
- **Verify model name**: Should be `gemini-2.5-flash` (not `gemini-2.5`)
- **Check API quota**: Gemini API has rate limits
- **Verify permissions**: Google API key must have Gemini API enabled

### File upload fails
- **Check file size**: Maximum 50MB per file
- **Verify file format**: Supported formats are PDF, TXT, MD
- **Check disk space**: Data directory needs free space
- **Check file permissions**: Ensure write access to `data/uploads/` directory

### Embedding generation fails
- **Rate limiting**: Too many requests too quickly
- **API quota exceeded**: Check Google API usage
- **Network timeout**: Try again or increase request timeout
- **Batch size too large**: Reduce batch size in `embeddings.py` if needed

### Quiz or Summary generation is slow
- **Check document size**: Larger documents need more processing
- **Check API limits**: Rate limits may be throttling requests
- **Increase timeout**: Adjust timeout in frontend API calls
- **Check network**: Verify stable internet connection

### Logo not displaying in header
- **Check file location**: `public/logo.png` must exist
- **Check file format**: Should be PNG, JPG, or supported image format
- **Check favicon**: Should also appear in browser tab
- **Clear cache**: Hard refresh browser (Ctrl+Shift+R on Windows)

## 📈 Performance Tips

1. **Text Chunking Strategy**
   - **Chunk Size**: Default 2000 characters (adjust in `text_splitter.py`)
   - Smaller chunks = faster retrieval but may lose context
   - Larger chunks = better context but slower processing
   - **Overlap**: Default 200 characters prevents context gaps

2. **Vector Search Optimization**
   - **Top-K Results**: Default 5-10 chunks (adjust in routes)
   - More results = better context but may introduce noise
   - Fewer results = faster retrieval but less context

3. **API Rate Limits**
   - **Google API**: Varies by quota
   - **Pinecone**: Depends on plan
   - **Batch Processing**: Process multiple chunks together
   - **Delay**: Add delays between batch requests if rate-limited

4. **Caching Strategy**
   - Results are cached in `data/cache/` directory
   - Reduces API calls for repeated queries
   - Clear cache if using different documents

5. **Frontend Performance**
   - **Response Rendering**: Large responses may be slow
   - **Pagination**: Use smaller quiz sizes for better performance
   - **Local Storage**: Browser stores some session data

6. **Database Optimization**
   - Pinecone index scales automatically
   - Delete unused documents to reduce index size
   - Monitor API usage regularly

## 🔐 Security

- API keys are stored in `.env` file (not committed to git)
- CORS is enabled for frontend-backend communication
- File uploads are validated for type and size
- Uploaded files are stored securely with document IDs

## 📝 Environment Variables Reference

### Backend Configuration (`backend/.env`)

```bash
# Google Generative AI (Gemini & Embeddings)
GOOGLE_API_KEY=sk-...your_google_api_key...

# Pinecone Vector Database
PINECONE_API_KEY=...your_pinecone_api_key...
PINECONE_INDEX_NAME=explaingen-index
PINECONE_ENV=us-east-1  # or your region (e.g., us-west-2)

# Flask Server Configuration
FLASK_PORT=8000
FLASK_DEBUG=False  # Set to True only during development
```

### Frontend Configuration (`frontend/.env`)

```bash
# API Endpoint
REACT_APP_API_URL=http://localhost:8000/api  # During development
# For production: https://your-deployed-backend-url/api
```

### Important Notes

- **Never commit `.env` files to git** (already in `.gitignore`)
- **Keep API keys secure** and never share them
- **Regenerate keys** if they're accidentally exposed
- **Use environment-specific keys** for development vs. production
- **Pinecone environment** must match your actual region (check dashboard)

## 🎓 Educational Use Cases

### For Students
1. **Study Material Analysis**
   - Upload textbooks and lecture notes
   - Ask clarifying questions instantly
   - Get concept explanations in simple terms
   
2. **Test Preparation**
   - Generate quizzes from study materials
   - Practice with multiple difficulty levels
   - Understand reasoning behind answers

3. **Concept Mastery**
   - Clarify concepts you're struggling with
   - Get multiple perspectives and explanations
   - Build understanding through guided learning

### For Teachers
1. **Assessment Creation**
   - Generate unique quizzes from curriculum materials
   - Create varied question sets for different classes
   - Ensure consistent learning objectives

2. **Student Support**
   - Provide instant feedback and explanations
   - Supplement teaching with AI-driven clarification
   - Reduce time spent on repetitive explanations

3. **Content Summarization**
   - Create study guides and summaries
   - Generate material at different complexity levels
   - Help students identify key concepts

### For Self-learners
1. **Self-paced Learning**
   - Learn at your own pace with instant support
   - Get explanations tailored to your understanding level
   - Practice with generated quizzes

2. **Knowledge Verification**
   - Test your understanding of new topics
   - Identify knowledge gaps
   - Get sources for further learning

## 🚀 Deployment Guide

### Deploy Backend (Heroku/Railway/Render)

1. **Prepare for Deployment**
   ```bash
   # Create Procfile
   echo "web: gunicorn app:app" > Procfile
   
   # Add production server
   pip install gunicorn
   pip freeze > requirements.txt
   ```

2. **Set Environment Variables**
   - On your deployment platform (Heroku/Railway/Render):
   ```
   GOOGLE_API_KEY=your_key
   PINECONE_API_KEY=your_key
   PINECONE_INDEX_NAME=explaingen-index
   PINECONE_ENV=your-region
   FLASK_PORT=8000
   FLASK_DEBUG=False
   ```

3. **Deploy**
   ```bash
   # Heroku
   heroku create your-app-name
   git push heroku main
   
   # Or use Railway/Render CLI
   ```

### Deploy Frontend (Vercel/Netlify)

1. **Build React App**
   ```bash
   npm run build
   ```

2. **Set Environment Variable**
   - On Vercel/Netlify dashboard:
   ```
   REACT_APP_API_URL=https://your-deployed-backend-url/api
   ```

3. **Deploy**
   ```bash
   # Vercel
   npm install -g vercel
   vercel
   
   # Or push to GitHub and connect to Netlify
   ```

### Important Deployment Notes

- **Ensure Pinecone index is created** before deploying
- **Test API keys** work in production environment
- **Set FLASK_DEBUG=False** in production
- **Use HTTPS** for production URLs
- **Monitor API usage** and rate limits
- **Set up logging** for debugging production issues

## 📜 License

MIT License - Feel free to use for educational and commercial purposes

## 🤝 Contributing

We welcome contributions from developers, educators, and enthusiasts!

### How to Contribute

1. **Fork the Repository**
   ```bash
   git clone https://github.com/your-username/ExplainGen.git
   cd ExplainGen
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Keep code clean and well-commented
   - Follow existing code style
   - Test thoroughly before submitting

4. **Submit a Pull Request**
   - Describe changes clearly
   - Reference any related issues
   - Include test results

### Contribution Areas

- **Backend**: New endpoints, better prompts, performance optimization
- **Frontend**: UI/UX improvements, new features, accessibility
- **Documentation**: Better guides, examples, troubleshooting
- **Testing**: Unit tests, integration tests, edge cases
- **Models**: Integration with other LLMs or embedding models

### Code of Conduct

- Be respectful and inclusive
- Help others learn and improve
- Report issues constructively
- Follow best practices

## 🆘 Support & Resources

### Getting Help

1. **Check Troubleshooting Section**
   - Common issues and solutions are documented above
   - Search for specific error messages

2. **Review API Documentation**
   - Detailed endpoint specifications
   - Request/response formats
   - Error codes and meanings

3. **Check Project Documentation**
   - Setup guide for detailed instructions
   - QUICKSTART guide for rapid deployment
   - API_DOCUMENTATION for endpoint details

4. **Open an Issue**
   - Provide detailed error description
   - Include your environment details (OS, Python version, etc.)
   - Share relevant error logs or console output

### Documentation Files

- `README.md` - This file, overview and general information
- `SETUP_GUIDE.md` - Detailed setup and configuration
- `QUICKSTART.md` - Quick start guide for rapid deployment
- `API_DOCUMENTATION.md` - Complete API endpoint reference
- `REQUIREMENTS_CHECKLIST.md` - Project requirement verification
- `COMPLETION_REPORT.md` - Implementation completion details

### Community & Feedback

- **Star the repository** if you find it useful
- **Share feedback** on features you'd like to see
- **Report bugs** with detailed reproduction steps
- **Suggest improvements** for better usability

## 🎯 Roadmap

### Completed ✅
- [x] Document upload and processing (PDF, TXT, MD)
- [x] Semantic search with Pinecone vectors
- [x] Question answering with Gemini
- [x] Quiz and summary generation
- [x] Explainability with structured responses
- [x] React frontend with improved UI
- [x] Logo integration and professional branding
- [x] Comprehensive documentation
- [x] Error handling and troubleshooting guide

### Planned (Future Versions)
- [ ] Multi-language support (Spanish, French, Mandarin, etc.)
- [ ] Advanced visualization (knowledge graphs, concept maps)
- [ ] Collaborative learning features (sharing, commenting)
- [ ] Mobile app version (iOS/Android)
- [ ] Real-time collaboration (multiple users on same document)
- [ ] Additional file format support (DOCX, PPT, Videos)
- [ ] Advanced analytics (learning progress tracking, insights)
- [ ] Custom LLM model support (alternatives to Gemini)
- [ ] Offline capability and local model support
- [ ] Browser extension for web content extraction

### Community-Requested Features
- Your ideas here! Open an issue to suggest features

## 👥 Team & Acknowledgments

### Project Team
ExplainGen was created as an educational AI project combining:
- **Generative AI & LLMs**: Powered by Google Gemini
- **Vector Databases**: Semantic search via Pinecone
- **Full-Stack Development**: Python backend + React frontend

### Technology Stack Acknowledgments

**Backend:**
- [Flask](https://flask.palletsprojects.com/) - Web framework
- [Google Generative AI](https://ai.google.dev/) - LLM and embeddings
- [Pinecone](https://www.pinecone.io/) - Vector database
- [pypdf](https://pypdf.readthedocs.io/) - PDF extraction
- [Tenacity](https://github.com/jmoiron/tenacity) - Resilient API retries

**Frontend:**
- [React](https://react.dev/) - UI framework
- [React Scripts](https://github.com/facebook/create-react-app) - Build tooling

### Special Thanks

- Google Gemini team for powerful LLM capabilities
- Pinecone team for excellent vector database service
- React community for amazing tools and documentation
- All educators and students using and improving ExplainGen

### Open Source

This project builds on the amazing open-source community. We're grateful to:
- All package maintainers
- Contributors to dependencies
- Developers sharing knowledge through documentation

## 🙏 Acknowledgments

**ExplainGen** represents the convergence of several cutting-edge technologies:

1. **Retrieval-Augmented Generation (RAG)** - Combining vector search with LLMs for accurate, sourced information
2. **Explainable AI** - Structured responses and source attribution for transparent reasoning
3. **Educational Technology** - Designed to enhance learning outcomes through personalized explanations
4. **Modern Web Stack** - Built with industry-standard tools for reliability and maintainability

---

**Happy Learning with ExplainGen! 🎓**

---

## 📊 Project Statistics

- **Total Files**: 38+ configuration, source, and documentation files
- **Backend Code**: ~1,200+ lines of Python
- **Frontend Code**: ~1,000+ lines of React/JSX
- **API Endpoints**: 11 fully functional endpoints
- **Supported Formats**: PDF, TXT, MD (3 formats)
- **Vector Dimensions**: 768 (Google embeddings)
- **Deployment Ready**: Yes, with production setup guides
- **Documentation**: 8+ comprehensive guides and references

## 🔗 Quick Links

- **API Base URL** (Development): `http://localhost:8000/api`
- **Frontend URL** (Development): `http://localhost:3000`
- **Health Check**: `GET http://localhost:8000/api/health`
- **API Info**: `GET http://localhost:8000/api/info`

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**License**: MIT  
**Status**: Production Ready ✅

---

**ExplainGen - Making AI Explainable, Learning Personalized**

```
 _____           _       _         ____            
| ____|_  _____ | | __ _(_)_ __   / ___| ___ _ __  
|  _| \ \/ / _ \| |/ _` | | '_ \  \___ \/ _ \ '_ \ 
| |___ >  < (_) | | (_| | | | | |  ___) |  __/ | | |
|_____/_/\_\___/|_|\__,_|_|_| |_| |____/ \___|_| |_|
                                                    
Explainable Generative AI for Personalized Learning
```

---
