#!/bin/bash
# Exercise 10 - Verify Ansible collection dependencies are installed
# (Collections are installed during codespace setup via code_space.sh)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Verifying Ansible Galaxy collections..."
ansible-galaxy collection list | grep -E "community\.docker|community\.general|community\.crypto|ansible\.netcommon|ansible\.utils" || {
  echo "Some collections not found. Installing from requirements.yaml..."
  ansible-galaxy collection install -r "$WORKSPACE_DIR/requirements.yaml"
}

echo ""
echo "Ansible collections are ready."
echo ""
echo "To start the exercise, run the playbook:"
echo "  cd $SCRIPT_DIR"
echo "  ansible-playbook bonkey_playbook.yaml"
