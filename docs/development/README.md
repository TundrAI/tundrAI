# 👩‍💻 Development Guide

## Getting Started

### Prerequisites
- Docker & Docker Compose
- Git
- Node.js 18+ (for local development)

### Local Development Setup

1. **Clone all repositories**
   ```bash
   git clone https://github.com/TundrAI/tundrai-deploy.git
   git clone https://github.com/TundrAI/tundrai-frontend.git
   git clone https://github.com/TundrAI/tundrai-backend.git
   git clone https://github.com/TundrAI/tundrai-inference.git
   ```

2. **Start development environment**
   ```bash
   cd tundrai-deploy
   docker-compose -f docker-compose.dev.yml up -d
   ```

## Development Workflow

Each service can be developed independently:

- **Frontend**: React development server with hot reload
- **Backend**: NestJS with auto-restart on changes
- **Inference**: Ollama with model management

## Code Standards

- TypeScript for all JavaScript code
- ESLint + Prettier for code formatting
- Conventional commits for git messages
- Jest for testing

## Service Communication

Services communicate via:
- HTTP APIs (Frontend ↔ Backend)
- gRPC (Backend ↔ Inference)
- Vector database queries (Backend ↔ Qdrant)
