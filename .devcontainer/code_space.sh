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

echo "Install tflint"
TFLINT_VERSION="0.50.0"
INSTALL_PATH="/usr/local/bin"
platform=$(uname -s | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)
if [ "$arch" == "x86_64" ]; then
            arch="amd64"
        fi
filename="tflint_${platform}_${arch}.zip"
curl -s -LO "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/${filename}"
sudo unzip -o  $filename -d "${INSTALL_PATH}"

echo "Done installing tflint"
echo "========================="

echo "install trivy"
TRIVY_VERSION="0.49.0"
curl --retry 3 --retry-delay 5 -sSL "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz" | sudo tar xz -C /usr/local/bin --overwrite
trivy server --download-db-only
echo "Done install trivy"
echo "========================="

echo "run pre-commit"
pre-commit run --all-files
echo "Done running pre-commit"
echo "========================="

echo "Setup Grafana"
cd /workspaces/BonkeyWonkers/exercise4
result=1
while [ $result -le 1 ];
do
  echo "starting docker compose"
  docker-compose up -d
  result=$(docker container ls | wc -l)
done

cd /workspaces/BonkeyWonkers
echo "============"

echo "Get test container"
docker pull dahicks/sample:latest

echo "Get stress test"
docker pull j0hnewhitley/docker-stress:v0.0.1

echo "============"

echo "Setting up Vault"
echo "============"

echo "Install tfupdate"
sudo go install github.com/minamijoyo/tfupdate@latest
tfupdate --version
echo "Done installing tfupdate"
echo "============"

echo "Install ACT"
cd /workspaces/BonkeyWonkers/exercise7

act --version
echo "Done installing ACT"
echo "==========="


# Start Minikube
echo "Starting Minikube"
minikube start --driver=docker --memory=6144 --cpus=2
minikube status
echo "Minikube Started"
minikube dashboard &
echo "==========="

# pip install ansible

echo "Completed Setup run following command:"

echo "cd /workspaces/BonkeyWonkers"
