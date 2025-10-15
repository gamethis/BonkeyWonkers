#!/bin/bash

DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends apt-utils dialog dnsutils httpie wget unzip curl jq
DEBIAN_FRONTEND=dialog

function getLatestVersion() {

  LATEST_ARR=($(wget -q -O- https://api.github.com/repos/hashicorp/terraform/releases 2> /dev/null | awk '/tag_name/ { print $2 }' | cut -d '"' -f 2 | cut -d 'v' -f 2 | sort -V -r))

  for ver in "${LATEST_ARR[@]}"; do
    if [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]]; then
      LATEST="$ver"
      break
    fi
  done
  echo -n "$LATEST"
}

function getLatestRepoVersion() {
  REPO=$1  #frrouting/frr
  DESIRED_VERSION=$2
  LATEST_ARR=($(wget -q -O- https://api.github.com/repos/${REPO}/releases 2> /dev/null | awk '/tag_name/ { print $2 }' | cut -d '"' -f 2 | cut -d 'v' -f 2 | sort -V -r))
  for ver in "${LATEST_ARR[@]}"; do
    if [[ -n "${DESIRED_VERSION}" ]]; then
      if [[ $ver =~ $DESIRED_VERSION ]] && [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]] ; then
        LATEST="$ver"
        break
      fi
    else
      if [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]] ; then
        LATEST="$ver"
        break
      fi
    fi
  done
  echo -n "$LATEST"
}

echo "Installing tools and dependencies"
echo "========================="

echo "install pre-commit"
pip install pre-commit
pre-commit install
echo "Done install pre-commit."
echo "========================="
echo "NOTE: Skipping 'pre-commit run --all-files' for faster setup. Run manually if needed."

echo "Installing tools in parallel for faster setup..."
echo "========================="

# Install tflint in background
(
  echo "Installing tflint..."
  TFLINT_VERSION="0.50.0"
  INSTALL_PATH="/usr/local/bin"
  platform=$(uname -s | tr '[:upper:]' '[:lower:]')
  arch=$(uname -m)
  if [ "$arch" == "x86_64" ]; then
    arch="amd64"
  fi
  filename="tflint_${platform}_${arch}.zip"
  curl -s -LO "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/${filename}"
  sudo unzip -o $filename -d "${INSTALL_PATH}"
  rm $filename
  echo "✓ tflint installed"
) &
TFLINT_PID=$!

# Install trivy in background
(
  echo "Installing trivy..."
  TRIVY_VERSION="0.49.0"
  curl --retry 3 --retry-delay 5 -sSL "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz" | sudo tar xz -C /usr/local/bin --overwrite
  echo "✓ trivy installed"
) &
TRIVY_PID=$!

# Install tfupdate in background
(
  echo "Installing tfupdate..."
  sudo go install github.com/minamijoyo/tfupdate@latest
  echo "✓ tfupdate installed"
) &
TFUPDATE_PID=$!

# Wait for all background jobs
wait $TFLINT_PID
wait $TRIVY_PID
wait $TFUPDATE_PID

echo "All tools installed successfully!"
echo "NOTE: Skipping 'trivy server --download-db-only' for faster setup. Will download on first use."
echo "========================="

echo "Install ACT"
cd /workspaces/BonkeyWonkers/exercise7
act --version
echo "Done installing ACT"
echo "==========="

cd /workspaces/BonkeyWonkers

echo ""
echo "=============================================="
echo "Setup complete! 🎉"
echo "=============================================="
echo ""
echo "Heavy operations moved to on-demand scripts for faster startup:"
echo "  - Exercise 4 (Grafana/Prometheus): .devcontainer/setup-exercise4.sh"
echo "  - Minikube: .devcontainer/setup-minikube.sh"
echo "  - Docker images: .devcontainer/pull-docker-images.sh"
echo ""
echo "Run these scripts when you need them:"
echo "  bash .devcontainer/setup-exercise4.sh"
echo "  bash .devcontainer/setup-minikube.sh"
echo "  bash .devcontainer/pull-docker-images.sh"
echo ""
