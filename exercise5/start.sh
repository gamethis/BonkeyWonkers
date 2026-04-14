#!/bin/bash
# Exercise 5 - Start Vault in dev mode
set -e

if vault status &>/dev/null 2>&1; then
  echo "Vault is already running."
  vault status
  exit 0
fi

export VAULT_ADDR='http://127.0.0.1:8200'

echo "Starting Vault dev server..."
vault server -dev \
  -dev-root-token-id=testtoken \
  -dev-listen-address=0.0.0.0:8200 \
  &>/tmp/vault.log &

VAULT_PID=$!
echo "Vault PID: $VAULT_PID"

# Wait for Vault to be ready
for i in {1..15}; do
  if vault status &>/dev/null 2>&1; then
    break
  fi
  sleep 1
done

vault status

echo ""
echo "Vault dev server is running."
echo "  Root token: testtoken"
echo "  UI:         http://localhost:8200"
echo "  VAULT_ADDR: http://127.0.0.1:8200"
echo ""
echo "Add the following to your shell or run before using the vault CLI:"
echo "  export VAULT_ADDR='http://127.0.0.1:8200'"
echo "  export VAULT_TOKEN='testtoken'"
echo ""
echo "On GitHub Codespaces: click the 'Ports' tab and open the forwarded"
echo "address for port 8200."
