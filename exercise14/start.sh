#!/usr/bin/env bash
# Exercise 14 — build the Go services and run Envoy in front of them.
# DO NOT EDIT.
#
# Backends:  idp/JWKS :9091   upstream :9090   ext_authz proxy :9000
# Envoy:     :8080 (the entrypoint clients hit)   admin :9901
set -euo pipefail
cd "$(dirname "$0")"

echo "building services..."
go build -o /tmp/bonkey-idp ./backend/idp
go build -o /tmp/bonkey-upstream ./backend/upstream
go build -o /tmp/bonkey-proxy ./proxy

echo "starting backends + proxy..."
/tmp/bonkey-idp &
IDP=$!
/tmp/bonkey-upstream &
UP=$!
/tmp/bonkey-proxy &
PX=$!
trap 'kill "$IDP" "$UP" "$PX" 2>/dev/null || true; docker rm -f bonkey-envoy 2>/dev/null || true' EXIT
sleep 1

echo "validating envoy.yaml..."
docker run --rm -v "$PWD/envoy.yaml:/etc/envoy/envoy.yaml:ro" \
  envoyproxy/envoy:v1.29-latest --mode validate -c /etc/envoy/envoy.yaml

echo "starting envoy on :8080 (Ctrl-C to stop)..."
exec docker run --rm --name bonkey-envoy --network host \
  -v "$PWD/envoy.yaml:/etc/envoy/envoy.yaml:ro" \
  envoyproxy/envoy:v1.29-latest -c /etc/envoy/envoy.yaml
