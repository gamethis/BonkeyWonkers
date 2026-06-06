#!/usr/bin/env bash
# Exercise 12 — build and run the backend (background) + proxy (foreground).
# Backend: :9090 (app) and :9091 (introspection). Proxy: :8080.
# Ctrl-C stops the proxy; the backend is stopped automatically on exit.
#
# The proxy is built with the Go race detector enabled, and configured to halt
# on the first data race, so concurrency bugs surface deterministically while
# you develop. Binaries are built into ./bin (gitignored).
set -euo pipefail
cd "$(dirname "$0")"

mkdir -p bin
echo "building backend + proxy (race detector on)..."
go build -o bin/backend ./backend
go build -race -o bin/proxy .

echo "starting backend..."
./bin/backend &
BACKEND_PID=$!
trap 'kill "$BACKEND_PID" 2>/dev/null || true' EXIT
sleep 1

echo "starting proxy (Ctrl-C to stop)..."
export GORACE="halt_on_error=1"
exec ./bin/proxy
