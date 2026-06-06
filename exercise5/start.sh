#!/bin/bash
# Exercise 5 - Start Vault in dev mode
set -e

export VAULT_ADDR='http://127.0.0.1:8200'

if vault status &>/dev/null; then
  echo "Vault is already running."
  vault status
  exit 0
fi
echo "Starting Vault dev server..."
vault server -dev \
  -dev-root-token-id=testtoken \
  -dev-listen-address=127.0.0.1:8200 \
  &>/tmp/vault.log &

VAULT_PID=$!
echo "$VAULT_PID" > /tmp/vault.pid
echo "Vault PID: $VAULT_PID (saved to /tmp/vault.pid)"

# Wait for Vault to be ready
for i in {1..15}; do
  if vault status &>/dev/null; then
    break
  fi
  if [ "$i" -eq 15 ]; then
    echo "❌ Vault did not become ready in time. Check /tmp/vault.log for errors."
    exit 1
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
