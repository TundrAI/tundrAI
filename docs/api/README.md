# 🔌 TundrAI API Reference

## Overview

The TundrAI backend exposes a RESTful API for document management and chat interactions.

## Base URL

- **Development**: `http://localhost:3001/api`
- **Production**: `https://your-domain.com/api`

## Core Endpoints

### Chat
- `POST /chat` - Send a question and receive an AI response
- `GET /chat/history` - Retrieve chat history

### Documents
- `POST /documents/ingest` - Ingest new documents
- `GET /documents` - List ingested documents
- `DELETE /documents/:id` - Remove a document

### System
- `GET /health` - Health check
- `GET /status` - System status and metrics

## Authentication

Authentication is configurable via environment variables. See deployment repository for setup details.

*Detailed API documentation will be generated using OpenAPI/Swagger.*
