#!/bin/bash
# Exercise 10 - Install Ansible collection dependencies and verify setup
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Installing Ansible Galaxy collections..."
ansible-galaxy collection install -r "$WORKSPACE_DIR/requirements.yaml"

echo ""
echo "Ansible collections are ready."
echo ""
echo "To start the exercise, run the playbook:"
echo "  cd $SCRIPT_DIR"
echo "  ansible-playbook bonkey_playbook.yaml"
