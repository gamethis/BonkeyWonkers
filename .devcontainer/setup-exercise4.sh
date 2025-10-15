#!/bin/bash
# Exercise 4: Grafana/Prometheus/Monitoring Setup
# Run this script when starting Exercise 4

echo "Setting up Exercise 4 - Grafana/Prometheus/Monitoring"
echo "=============================================="

cd /workspaces/BonkeyWonkers/exercise4

echo "Starting docker-compose services..."
result=1
while [ $result -le 1 ];
do
  echo "starting docker compose"
  docker-compose up -d
  result=$(docker container ls | wc -l)
done

echo "Exercise 4 setup complete!"
echo "Services available:"
echo "  - Grafana: http://localhost:3000"
echo "  - Prometheus: http://localhost:9090"
echo "  - cAdvisor: http://localhost:8081"
echo "  - Redis: localhost:6379"
echo "  - Vault: http://localhost:8200"
echo "  - Wireshark: http://localhost:3002"
echo "  - Registry: http://localhost:5000"
