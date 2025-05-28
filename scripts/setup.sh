#!/bin/bash
echo "🚀 Setting up TundrAI development environment..."

# Copy environment file if it doesn't exist
if [ ! -f config/.env.development ]; then
    cp config/.env.example config/.env.development
    echo "✅ Created config/.env.development from template"
fi

# Install backend dependencies
if [ -f backend/package.json ]; then
    echo "📦 Installing backend dependencies..."
    cd backend && npm install && cd ..
fi

# Install frontend dependencies
if [ -f frontend/package.json ]; then
    echo "📦 Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

echo "✅ Setup complete! Run './scripts/dev-start.sh' to start development servers."
