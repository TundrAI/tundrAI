# 🏗️ TundrAI Architecture

## System Overview

TundrAI follows a microservices architecture with clear separation of concerns:

### Service Architecture

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Frontend  │    │   Backend   │    │  Inference  │
│   (React)   │◄──►│  (NestJS)   │◄──►│  (Ollama)   │
└─────────────┘    └─────────────┘    └─────────────┘
                           │
                           ▼
                   ┌─────────────┐
                   │  Vector DB  │
                   │  (Qdrant)   │
                   └─────────────┘
```

### Data Flow

1. **Document Ingestion**: Documents → Chunks → Embeddings → Vector Store
2. **Query Processing**: User Question → Embedding → Similarity Search → Context
3. **Response Generation**: Context + Question → LLM → Smart Answer

## Technology Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Frontend | React + TypeScript | User interface |
| Backend | NestJS + TypeScript | API & RAG logic |
| LLM | Ollama | Local inference |
| Vector Store | Qdrant | Semantic search |
| Orchestration | Docker Compose | Service coordination |

## Deployment Architecture

All services are containerized and orchestrated via Docker Compose for both development and production environments.
