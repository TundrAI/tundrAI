#!/bin/bash
echo "🚀 Starting TundrAI development environment..."

# Start Docker services (vector DB, inference server)
echo "🐳 Starting Docker services..."
docker-compose -f docker-compose.yml up -d

# Wait a moment for services to start
sleep 3

# Start backend in background
if [ -f backend/package.json ]; then
    echo "🔧 Starting backend..."
    cd backend && npm run start:dev &
    BACKEND_PID=$!
    cd ..
fi

# Start frontend in background
if [ -f frontend/package.json ]; then
    echo "🎨 Starting frontend..."
    cd frontend && npm run dev &
    FRONTEND_PID=$!
    cd ..
fi

echo "✅ Development environment started!"
echo "🔧 Backend: http://localhost:3000"
echo "🎨 Frontend: http://localhost:3001"
echo "📊 Vector DB: http://localhost:8000"
echo "🧠 Inference: http://localhost:11434"
echo ""
echo "Press Ctrl+C to stop all services..."

# Wait for interrupt
trap 'echo "🛑 Stopping services..."; kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; docker-compose down; exit' INT
wait
