# API Documentation

## Overview

ExplainGen provides a RESTful API for managing documents and generating intelligent responses using the RAG pipeline.

## Base URL
```
http://localhost:8000/api
```

## Authentication

Currently, the API does not require authentication tokens. API keys (Google and Pinecone) are configured server-side through environment variables.

---

## Endpoints

### 1. Health Check

**Endpoint:** `GET /health`

**Description:** Check if the API and all services are healthy and running.

**Response (200 OK):**
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

**cURL Example:**
```bash
curl http://localhost:8000/api/health
```

---

### 2. API Information

**Endpoint:** `GET /info`

**Description:** Get information about available API endpoints and features.

**Response (200 OK):**
```json
{
  "name": "ExplainGen",
  "description": "Explainable Generative AI for Personalized Learning",
  "version": "1.0.0",
  "endpoints": { ... }
}
```

**cURL Example:**
```bash
curl http://localhost:8000/api/info
```

---

## Document Management

### 3. Upload Document

**Endpoint:** `POST /upload`

**Description:** Upload a document (PDF or text file) to be processed and stored in Pinecone.

**Request:**
- Method: `POST`
- Content-Type: `multipart/form-data`
- Body: 
  - `file` (required): PDF or text file

**Response (200 OK):**
```json
{
  "success": true,
  "document_id": "550e8400-e29b-41d4-a716-446655440000",
  "filename": "study_notes.pdf",
  "chunks_created": 15,
  "embeddings_stored": 15,
  "text_length": 8234,
  "message": "Successfully processed study_notes.pdf with 15 chunks"
}
```

**Error Responses:**
- `400 Bad Request`: No file provided
- `400 Bad Request`: Unsupported file type
- `500 Internal Server Error`: Processing failed

**cURL Example:**
```bash
curl -X POST -F "file=@study_notes.pdf" http://localhost:8000/api/upload
```

**JavaScript Example:**
```javascript
const formData = new FormData();
formData.append('file', fileInput.files[0]);

fetch('http://localhost:8000/api/upload', {
  method: 'POST',
  body: formData
})
.then(res => res.json())
.then(data => console.log(data));
```

---

### 4. List Documents

**Endpoint:** `GET /documents`

**Description:** Get a list of all uploaded documents.

**Response (200 OK):**
```json
{
  "success": true,
  "documents": [
    {
      "document_id": "550e8400-e29b-41d4-a716-446655440000",
      "filename": "study_notes.pdf",
      "chunks": 15,
      "text_length": 8234,
      "embeddings": 15
    }
  ],
  "total": 1
}
```

**cURL Example:**
```bash
curl http://localhost:8000/api/documents
```

---

### 5. Delete Document

**Endpoint:** `DELETE /documents/{document_id}`

**Description:** Delete a document from the system.

**URL Parameters:**
- `document_id` (required): ID of the document to delete

**Response (200 OK):**
```json
{
  "success": true,
  "message": "Document 550e8400-e29b-41d4-a716-446655440000 deleted successfully"
}
```

**Error Responses:**
- `404 Not Found`: Document does not exist

**cURL Example:**
```bash
curl -X DELETE http://localhost:8000/api/documents/550e8400-e29b-41d4-a716-446655440000
```

---

## Question Answering

### 6. Ask Question

**Endpoint:** `POST /ask`

**Description:** Ask a question about the uploaded documents and get an AI-generated answer with explanation.

**Request:**
```json
{
  "question": "What is photosynthesis?",
  "top_k": 5,
  "include_sources": true
}
```

**Parameters:**
- `question` (required, string): The question to ask
- `top_k` (optional, integer): Number of relevant chunks to retrieve (default: 5)
- `include_sources` (optional, boolean): Include source information (default: false)

**Response (200 OK):**
```json
{
  "success": true,
  "question": "What is photosynthesis?",
  "answer": "Photosynthesis is a process...",
  "chunks_used": 5,
  "top_k": 5,
  "sources": [
    {
      "source": "study_notes.pdf",
      "chunk_id": 0,
      "relevance_score": 0.92
    }
  ]
}
```

**Error Responses:**
- `400 Bad Request`: No question provided
- `404 Not Found`: No relevant content found

**cURL Example:**
```bash
curl -X POST http://localhost:8000/api/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "What is photosynthesis?", "include_sources": true}'
```

**JavaScript Example:**
```javascript
fetch('http://localhost:8000/api/ask', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    question: 'What is photosynthesis?',
    include_sources: true
  })
})
.then(res => res.json())
.then(data => console.log(data.answer));
```

---

### 7. Clarify Concept

**Endpoint:** `POST /clarify`

**Description:** Get a detailed explanation of a specific concept from the documents.

**Request:**
```json
{
  "concept": "mitochondria",
  "top_k": 5
}
```

**Parameters:**
- `concept` (required, string): The concept to explain
- `top_k` (optional, integer): Number of relevant chunks (default: 5)

**Response (200 OK):**
```json
{
  "success": true,
  "concept": "mitochondria",
  "explanation": "Mitochondria is an organelle...",
  "chunks_used": 5
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8000/api/clarify \
  -H "Content-Type: application/json" \
  -d '{"concept": "mitochondria"}'
```

---

## Content Generation

### 8. Generate Summary

**Endpoint:** `POST /summary`

**Description:** Generate a summary of all uploaded documents.

**Request:**
```json
{
  "level": "intermediate",
  "top_k": 20
}
```

**Parameters:**
- `level` (optional, string): Summary level - "basic", "intermediate", or "advanced" (default: intermediate)
- `top_k` (optional, integer): Number of chunks to include (default: 20)

**Response (200 OK):**
```json
{
  "success": true,
  "summary": "This document covers...",
  "level": "intermediate",
  "chunks_used": 20
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8000/api/summary \
  -H "Content-Type: application/json" \
  -d '{"level": "intermediate"}'
```

---

### 9. Generate Topic Summary

**Endpoint:** `POST /summary-topic`

**Description:** Generate a summary for a specific topic.

**Request:**
```json
{
  "topic": "photosynthesis",
  "level": "basic",
  "top_k": 10
}
```

**Parameters:**
- `topic` (required, string): Topic to summarize
- `level` (optional, string): "basic", "intermediate", or "advanced"
- `top_k` (optional, integer): Number of chunks (default: 10)

**Response (200 OK):**
```json
{
  "success": true,
  "topic": "photosynthesis",
  "summary": "Photosynthesis is the process...",
  "level": "basic",
  "chunks_used": 10
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8000/api/summary-topic \
  -H "Content-Type: application/json" \
  -d '{"topic": "photosynthesis", "level": "basic"}'
```

---

### 10. Generate Quiz

**Endpoint:** `POST /quiz`

**Description:** Generate quiz questions from the documents.

**Request:**
```json
{
  "num_questions": 5,
  "difficulty": "medium",
  "top_k": 15
}
```

**Parameters:**
- `num_questions` (optional, integer): Number of questions (1-20, default: 5)
- `difficulty` (optional, string): "easy", "medium", or "hard"
- `top_k` (optional, integer): Number of chunks (default: 15)

**Response (200 OK):**
```json
{
  "success": true,
  "quiz": "Q1: Multiple choice question...",
  "num_questions": 5,
  "difficulty": "medium",
  "topic": "General",
  "chunks_used": 15
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8000/api/quiz \
  -H "Content-Type: application/json" \
  -d '{"num_questions": 5, "difficulty": "medium"}'
```

---

### 11. Generate Topic Quiz

**Endpoint:** `POST /quiz-topic`

**Description:** Generate quiz questions for a specific topic.

**Request:**
```json
{
  "topic": "photosynthesis",
  "num_questions": 3,
  "difficulty": "easy"
}
```

**Parameters:**
- `topic` (required, string): Topic for the quiz
- `num_questions` (optional, integer): Number of questions (default: 5)
- `difficulty` (optional, string): "easy", "medium", or "hard"
- `top_k` (optional, integer): Number of chunks (default: 15)

**Response (200 OK):**
```json
{
  "success": true,
  "topic": "photosynthesis",
  "quiz": "Q1: What is photosynthesis...",
  "num_questions": 3,
  "difficulty": "easy",
  "chunks_used": 9
}
```

**cURL Example:**
```bash
curl -X POST http://localhost:8000/api/quiz-topic \
  -H "Content-Type: application/json" \
  -d '{"topic": "photosynthesis", "num_questions": 3, "difficulty": "easy"}'
```

---

## Error Handling

All errors follow this format:

```json
{
  "error": "Error message describing what went wrong"
}
```

### Common HTTP Status Codes:
- `200 OK`: Request successful
- `400 Bad Request`: Invalid parameters or missing required fields
- `404 Not Found`: Resource not found
- `500 Internal Server Error`: Server-side error

---

## Rate Limiting

Current version has no rate limiting. For production, consider implementing:
- API key-based rate limiting
- Per-IP rate limiting
- Request queuing

---

## Request/Response Examples

### Complete Flow Example

```bash
# 1. Check health
curl http://localhost:8000/api/health

# 2. Upload document
curl -X POST -F "file=@lecture_notes.pdf" http://localhost:8000/api/upload

# 3. Ask question
curl -X POST http://localhost:8000/api/ask \
  -H "Content-Type: application/json" \
  -d '{"question": "Explain the main concepts?"}'

# 4. Generate summary
curl -X POST http://localhost:8000/api/summary \
  -H "Content-Type: application/json" \
  -d '{"level": "basic"}'

# 5. Generate quiz
curl -X POST http://localhost:8000/api/quiz \
  -H "Content-Type: application/json" \
  -d '{"num_questions": 5}'
```

---

## Response Times

Typical response times (approximate):
- Upload: 10-30 seconds (depends on file size)
- Ask Question: 5-15 seconds
- Generate Summary: 10-20 seconds
- Generate Quiz: 15-30 seconds

---

## Best Practices

1. **File Upload**: Keep files under 20MB for optimal performance
2. **Questions**: Be specific and clear in your questions
3. **Top-K**: Use 5-10 for targeted content, 15-20 for comprehensive context
4. **Error Handling**: Always check `success` field in responses
5. **Concurrency**: Process requests sequentially to avoid rate limits

---

**For more information, see README.md and SETUP_GUIDE.md**
