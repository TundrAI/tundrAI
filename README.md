# 🧊 TundrAI – Documentation Chatbot Project

## 🧭 Project Overview

TundrAI is a **fully open-source, self-hosted AI-powered chatbot** that answers user questions based on documentation content. It will be written in **TypeScript**, with a **React frontend** and a **Node.js backend**, and will use a **self-hosted inference server running open-source LLMs**.

While the primary use case is to support a specific software product, the project is designed to be **documentation-agnostic** — it should work with any set of supported documents and can be used across different software projects or use cases.

TundrAI will be developed and published on the creator's personal GitHub account, and when mature, will be offered to the company for internal integration.

---

## 🏗️ Repository Architecture **[FINAL]**

**Decision Made: Multi-Repository Structure**

| Repository | Purpose | Issues | Status |
|------------|---------|---------|---------|
| `tundrAI` | **Project hub** - Planning, documentation, architecture overview | 2 | ✅ Created |
| `tundrai-backend` | NestJS API with RAG logic, document processing, authentication | 26 | 🎯 **Current Focus** |
| `tundrai-frontend` | React + TypeScript chat interface | 10 | ⏳ Later |
| `tundrai-deploy` | Docker orchestration, configs, deployment scripts | 7 | ⏳ Later |
| `tundrai-inference` | Ollama server setup and model management | 0 | ⏳ Future |

**Total Issues: 45 across 5 milestones**

**Why Multi-Repo:**
- Clean service boundaries and independent development
- Each service builds its own Docker image
- Professional separation for company adoption
- Easier to open-source individual components later

---

## 🔧 Tech Stack **[FINAL DECISIONS]**

| Layer        | Technology              | Notes                   |
| ------------ | ----------------------- | ----------------------- |
| Frontend     | React + TypeScript      | Vite build system       |
| Backend      | NestJS + TypeScript     | **Starting point**      |
| Database     | PostgreSQL + TypeORM    | Conversations, metadata |
| Cache        | Redis                   | Performance optimization |
| Vector Store | Qdrant                  | Document embeddings     |
| Inference    | Ollama                  | Local LLM hosting       |
| Auth         | JWT + Passport.js       | Config-driven, SSO-ready |
| Logging      | Winston + JSON          | Structured observability |
| Container    | Docker + Docker Compose | Docker-first approach   |

**Full Stack Architecture:**
```
React UI ↔ NestJS API ↔ PostgreSQL (conversations)
                     ↔ Redis (caching)
                     ↔ Qdrant (vectors)
                     ↔ Ollama (LLM)
```

---

## 🎯 Development Milestones **[CURRENT PLAN]**

**Timeline:** 12-16 weeks total, ~10 hours/week, solo development  
**Target:** Company demo in ~8 weeks, Enterprise ready in ~16 weeks

### **Milestone 1: Backend Core** ⚡ (Weeks 1-4, ~40h) - 9 Issues
**Status: 🎯 READY TO START**

**Backend Foundation & RAG Pipeline**
- ✅ Repository architecture decisions
- ✅ Technical architecture decisions
- 🎯 **NEXT:** NestJS project setup with development tooling
- PostgreSQL + TypeORM + User entity setup
- JWT authentication with Passport implementation
- Document ingestion pipeline (PDF, MD, HTML, TXT parsing)  
- Vector database integration (Qdrant setup and configuration)
- Ollama LLM integration and prompt management
- Core chat API endpoints with conversation memory
- Testing infrastructure with 100% coverage requirement

**Success Criteria:** Complete chatbot backend that can ingest documents, authenticate users, and provide intelligent answers with conversation memory

### **Milestone 2: Integration & UI** 🎨 (Weeks 5-6, ~20h) - 13 Issues
**Backend Integration + Frontend Development + Docker Setup**
- CORS configuration and API optimization for frontend consumption
- File upload endpoints and Swagger documentation
- Docker configurations for all services and development orchestration
- React + TypeScript project setup with Vite build system
- Chat interface components and authentication UI
- Document upload interface and backend API integration
- Production docker-compose configuration

**Success Criteria:** End-to-end web interface with complete frontend-backend integration

### **Milestone 3: Demo Polish** ✨ (Weeks 7-8, ~20h) - 9 Issues
**MVP Completion & Company Demo Preparation**
- Responsive design and mobile optimization
- Comprehensive error handling and user feedback systems
- Dark/light theme support and accessibility compliance
- Application monitoring, logging dashboard, and security hardening
- Performance optimization and caching strategies
- Comprehensive user documentation and demo presentation materials

**Success Criteria:** Company-ready demonstration with polished user experience

### **Milestone 4: Enterprise Features** 🏢 (Weeks 9-12, ~40h) - 8 Issues
**Advanced Features for Company Integration**
- Role-based access control (RBAC) and SSO integration (Google, SAML, LDAP)
- User profile management and admin dashboard interfaces
- Support for additional document formats (DOCX, PPTX, XLSX, EPUB)
- Intelligent document versioning and advanced RAG features
- AI conversation enhancements (summarization, suggestions, categorization)

**Success Criteria:** Enterprise-ready feature set suitable for company deployment

### **Milestone 5: Production Scale** 🚀 (Weeks 13-16, ~40h) - 6 Issues
**Production-Grade Infrastructure & Compliance**
- Horizontal scaling, load balancing, and CI/CD pipeline setup
- Business intelligence dashboard and advanced reporting features
- Audit logging, compliance features, and disaster recovery
- High availability configurations and enterprise security hardening

**Success Criteria:** Production-scale deployment with enterprise compliance and monitoring

---

## 🧠 Core Workflow

### Step 1: Ingest Documentation
* Supported formats: **PDF**, **Markdown**, **HTML**, and **plain text**
* Documents are parsed and split into chunks
* Chunks are embedded (converted into numerical vectors)
* Embeddings are stored in Qdrant vector database
* Document metadata stored in PostgreSQL

### Step 2: Handle User Questions
* User types a question in the chat UI
* The backend embeds the question using cached embeddings
* Qdrant retrieves the most similar chunks from the docs
* Previous conversation context loaded from PostgreSQL

### Step 3: Generate Answer
* The backend builds a prompt using the question + context + conversation history
* The prompt is sent to Ollama inference server
* The answer is returned to the user
* Conversation is persisted to PostgreSQL

---

## 📂 Document Ingestion Workflow

* **API Endpoints**: `POST /documents/upload` for single files, `POST /documents/batch` for multiple
* **File System Watching**: Automatic processing of files added to configured directories
* **Processing Pipeline**: Parse → Chunk → Embed → Store in Qdrant → Save metadata to PostgreSQL
* **Configurable via environment variables**
* **Original files discarded after processing** (metadata retained)

### Document Versioning
* Git-based versioning for documentation tracking
* Automated re-ingestion triggers via file system monitoring
* Change tracking and incremental updates

---

## 🔐 Authentication Strategy **[FINAL DESIGN]**

### **Flexible Configuration**
```env
ENABLE_AUTH=false|true|hybrid
ALLOW_SELF_REGISTRATION=true|false
ADMIN_EMAIL=admin@company.com
ADMIN_PASSWORD=initial-secure-password
```

### **JWT + Passport Architecture**
- **Local Authentication**: JWT tokens with refresh tokens
- **SSO Ready**: Passport.js strategies for future Google/SAML integration
- **Role-Based Access**: Admin, User, Uploader roles
- **Session Management**: 15-30 min access tokens, 7-day refresh tokens

### **User Management**
- **Self-registration**: Configurable (enable/disable)
- **Admin creation**: Environment variable seeding
- **Password reset**: Email-based + admin override
- **Single-tenant**: One instance per organization (simple, focused)

---

## 🐳 Deployment Strategy **[FINAL APPROACH]**

### **Docker-First Development**
```yaml
# docker-compose.dev.yml
services:
  backend:
    volumes:
      - ./src:/app/src          # Live code sync
      - /app/node_modules       # Preserve container modules
  postgres:    # User data, conversations
  redis:       # Performance caching  
  qdrant:      # Vector embeddings
  ollama:      # LLM inference
```

**Benefits:**
- Full containerization with hot reload
- Production-development parity
- Easy onboarding and deployment

### **Image Strategy**
- Each service repo builds and publishes Docker images
- Deployment repo orchestrates pre-built images
- Supports both local development and remote deployment

---

## 🔧 Technical Implementation Details **[ARCHITECTURE DECISIONS]**

### **API Design Standards**
- **Base URL**: `/api/v1/` (versioned from day 1)
- **Response Format**: `{data, message, success}` wrapper
- **Error Schema**: `{error, message, statusCode, details}`
- **Pagination**: `{data, total, page, limit}` for lists

### **Configuration Management**
- **Single `.env` file** for all services
- **Environment validation** (fail fast on missing variables)
- **Secrets management** via environment variables

### **Testing Strategy**
- **Unit tests** for MVP (faster feedback, easier maintenance)
- **Separate test database** (clean, realistic testing)
- **Integration tests** for RAG pipeline post-MVP
- **100% code coverage requirement** with Jest testing framework

### **Logging & Observability**
- **Structured JSON logging** with Winston
- **Log levels**: error, warn, info, debug
- **Performance metrics**: embedding generation time, LLM response time
- **Error tracking**: Built-in logging for MVP, Sentry integration later

### **Caching Strategy**
- **Document embeddings**: Cached in Qdrant (permanent)
- **Query embeddings**: Cached in Redis (temporary)
- **Conversation context**: Recent messages cached in Redis
- **Document metadata**: Frequent lookups cached in Redis

---

## ⚙️ Configuration & Behavior

### **RAG Mode Configuration**
* **Strict RAG**: Only answer from ingested documents
* **Fallback Mode**: General AI assistance when docs don't contain answer
* Configurable via environment variables

### **Authentication & Access**
* **Public Mode**: Open access chatbot
* **Private Mode**: Requires login to access
* **Hybrid Mode**: Public read, private document upload
* Fully configurable deployment option

### **Language Support**
* **MVP**: English and French
* **Future**: Additional language support planned

---

## 🧩 Development Context **[CURRENT STATUS]**

### **Project State**
- ✅ Project architecture decided (multi-repo)
- ✅ Repository structure created
- ✅ Milestones and timeline planned (45 issues across 5 milestones)
- ✅ **Technical architecture finalized**
- ✅ **Authentication strategy decided**
- ✅ **Development environment planned**
- ✅ **Issue organization completed** (Priority fields + component labels)
- 🎯 **READY: Backend repository setup and first issue implementation**

### **Development Approach**
- **Solo development** initially
- **Backend-first strategy** (core RAG logic)
- **Docker-first development** (bind mounts for hot reload)
- **API-driven development** (validate with curl/Postman before UI)
- **Database-first approach** (PostgreSQL + Auth setup first)
- **100% test coverage** (Jest with coverage reporting)

### **Key Technical Decisions Made**
- **NestJS** for backend (structured, TypeScript-native)
- **PostgreSQL + TypeORM** for relational data (conversations, users, metadata)
- **Redis** for performance caching (queries, context, metadata)
- **Qdrant** for vector database (production-ready)
- **Ollama** for LLM inference (self-hosted)
- **JWT + Passport.js** for authentication (SSO-ready)
- **Winston** for structured logging (JSON format)
- **Multi-repo** architecture (service independence)

### **Implementation Order**
1. **NestJS Project Setup**: Development tooling, ESLint, Prettier, testing infrastructure
2. **Database Setup**: PostgreSQL + TypeORM + User entities
3. **Authentication**: JWT + Passport + Auth guards
4. **Core RAG Pipeline**: Document processing + Qdrant + Ollama
5. **Conversation System**: Message persistence + context handling
6. **API Endpoints**: Chat, document upload, user management

---

## 🚧 MVP Scope **[CONFIRMED]**

**Core Requirements:**
- Ingest PDFs and Markdown files via API and file system watching
- English language support (French as stretch goal)
- RAG-based question answering with conversation memory
- REST API for all operations with JWT authentication
- Basic web chat interface with user management
- Full Docker deployment with docker-compose
- Structured logging and error handling
- 100% test coverage with comprehensive reporting

**Success Definition:**
Can demonstrate user registration/login, uploading documentation, engaging in contextual conversations through a web interface, and receiving contextually accurate answers that remember previous conversation context.

---

## 🎯 Future Enhancements **[POST-MVP]**

* Admin web panel for user and system management
* Real-time logging dashboard and feedback systems
* Multi-user support with advanced role-based access
* Analytics dashboard and usage metrics
* Additional document formats (DOCX, EPUB)
* Automatic re-ingestion on file changes
* SSO integration (Google, SAML, LDAP)
* Multi-tenant architecture (multiple organizations)
* Enterprise deployment pipelines (Azure/K8s)
* Advanced security and compliance features
* Performance optimization and advanced caching
* 2FA and enhanced security features
