#!/bin/bash
echo "📚 Starting document ingestion..."

# Check if backend is running
if ! curl -s http://localhost:3000/health > /dev/null; then
    echo "❌ Backend not running. Start it first with './scripts/dev-start.sh'"
    exit 1
fi

# Trigger ingestion
REFRESH=${1:-false}
echo "🔄 Triggering ingestion (refresh=$REFRESH)..."
curl -X POST "http://localhost:3000/ingest?refresh=$REFRESH"

echo "✅ Ingestion complete!"
