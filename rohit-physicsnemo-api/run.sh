#!/bin/bash

# ─────────────────────────────────────────────
#  run.sh — Start the rohit-physicsnemo-api
# ─────────────────────────────────────────────

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-8000}"
RELOAD="${RELOAD:-true}"
WORKERS="${WORKERS:-1}"

echo "=========================================="
echo "  rohit-physicsnemo-api"
echo "=========================================="
echo "  Host    : $HOST"
echo "  Port    : $PORT"
echo "  Reload  : $RELOAD"
echo "  Workers : $WORKERS"
echo "  URL     : http://$HOST:$PORT"
echo "  Docs    : http://$HOST:$PORT/docs"
echo "=========================================="

# Use uv if available, otherwise fall back to uvicorn directly
if command -v uv &>/dev/null; then
    echo "Starting with uv..."
    if [ "$RELOAD" = "true" ]; then
        uv run uvicorn main:app --host "$HOST" --port "$PORT" --reload
    else
        uv run uvicorn main:app --host "$HOST" --port "$PORT" --workers "$WORKERS"
    fi
else
    echo "Starting with uvicorn..."
    if [ "$RELOAD" = "true" ]; then
        uvicorn main:app --host "$HOST" --port "$PORT" --reload
    else
        uvicorn main:app --host "$HOST" --port "$PORT" --workers "$WORKERS"
    fi
fi
