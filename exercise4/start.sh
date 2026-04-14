#!/bin/bash
# Exercise 4 - Start Grafana + Prometheus stack
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Starting Grafana and Prometheus via docker-compose..."
docker-compose up -d

echo ""
echo "Services are starting. Access them at:"
echo "  Grafana:    http://localhost:3000  (admin / admin)"
echo "  Prometheus: http://localhost:9090"
echo ""
echo "On GitHub Codespaces: click the 'Ports' tab and open the forwarded address."
