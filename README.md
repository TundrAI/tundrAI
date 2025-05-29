# 🧊 TundrAI

> **AI-powered documentation chatbot** - Fully open-source, self-hosted RAG solution

[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![TypeScript](https://img.shields.io/badge/TypeScript-Ready-blue.svg)](https://www.typescriptlang.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED.svg)](https://www.docker.com/)

TundrAI transforms your documentation into an intelligent chatbot that can answer questions, provide guidance, and help users navigate your content using advanced RAG (Retrieval-Augmented Generation) technology.

## 🚀 Quick Start

```bash
# 1. Clone the deployment repository
git clone https://github.com/TundrAI/tundrai-deploy.git
cd tundrai-deploy

# 2. Start with Docker Compose (that's it!)
docker-compose up -d
```

**📍 Access:** Open http://localhost:3000 and start chatting with your docs!

## 🏗️ Architecture

TundrAI consists of **4 specialized services** working together:

| Service | Repository | Description |
|---------|------------|-------------|
| 🎨 **Frontend** | [`tundrai-frontend`](https://github.com/TundrAI/tundrai-frontend) | React + TypeScript chat interface |
| ⚡ **Backend** | [`tundrai-backend`](https://github.com/TundrAI/tundrai-backend) | NestJS API with RAG logic |
| 🤖 **Inference** | [`tundrai-inference`](https://github.com/TundrAI/tundrai-inference) | Ollama LLM server setup |
| 🐳 **Deployment** | [`tundrai-deploy`](https://github.com/TundrAI/tundrai-deploy) | Docker orchestration & configs |

### System Flow
```
Documents → Vector DB → LLM → Smart Answers
    ↓           ↓         ↓         ↓
   PDF,MD    Qdrant    Ollama   React UI
```

## ✨ Key Features

- **🔒 Self-Hosted**: Complete control over your data and infrastructure
- **📚 Multi-Format**: PDF, Markdown, HTML, and plain text support
- **🌍 Multilingual**: English and French support (more languages planned)
- **🎯 Smart RAG**: Context-aware answers from your documentation
- **🐳 Docker-First**: One command deployment with docker-compose
- **⚙️ Configurable**: Strict RAG mode or general AI assistance
- **🔐 Flexible Auth**: Public or private deployment options

## 📖 Documentation

| Topic | Link |
|-------|------|
| **Architecture Overview** | [docs/architecture/](docs/architecture/) |
| **Deployment Guide** | [Deployment Repo](https://github.com/TundrAI/tundrai-deploy) |
| **API Reference** | [docs/api/](docs/api/) |
| **Development Setup** | [docs/development/](docs/development/) |

## 🗺️ Project Status

**Current Version:** `v0.1.0-alpha`

**Development Roadmap:** [planning/roadmap/](planning/roadmap/)

**Active Milestones:** [planning/milestones/](planning/milestones/)

## 🤝 Contributing

We welcome contributions! Each service repository has its own contribution guidelines:

- **Issues & Discussions**: Use this main repository for project-wide discussions
- **Feature Requests**: Submit in the relevant service repository
- **Bug Reports**: Report in the specific service repository

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🏢 Enterprise Ready

TundrAI is designed for professional deployment and can be easily integrated into existing infrastructure. Perfect for:

- Internal documentation portals
- Customer support systems  
- Knowledge base enhancement
- Developer documentation assistance

---

**⭐ Star this project** if you find it useful and **watch** for updates!
