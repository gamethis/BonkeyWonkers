#!/bin/bash

DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends apt-utils dialog dnsutils httpie wget unzip curl jq
DEBIAN_FRONTEND=dialog

function getLatestVersion() {

  LATEST_ARR=($(wget -q -O- https://api.github.com/repos/hashicorp/terraform/releases 2> /dev/null | awk '/tag_name/ { print $2 }' | cut -d '"' -f 2 | cut -d 'v' -f 2))

  for ver in "${LATEST_ARR[@]}"; do
    if [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]]; then
      LATEST="$ver"
      break
    fi
  done
  echo -n "$LATEST"
}

echo "Install Terraform"

VERSION=$(getLatestVersion)

cd ~
wget "https://releases.hashicorp.com/terraform/"$VERSION"/terraform_"$VERSION"_linux_amd64.zip"
unzip "terraform_"$VERSION"_linux_amd64.zip"
sudo install terraform /usr/local/bin/

echo "Done Installing Terraform"
echo "========================="

echo "install pre-commit"
pip install pre-commit
pre-commit install
echo "Done install pre-commit."
echo "========================="

echo "Install tflint"
TFLINT_VERSION="0.48.0"
INSTALL_PATH="/usr/local/bin"
platform=$(uname -s | tr '[:upper:]' '[:lower:]')
arch=$(uname -m)
if [ "$arch" == "x86_64" ]; then
            arch="amd64"
        fi
filename="tflint_${platform}_${arch}.zip"
curl -s -LO "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/${filename}"
sudo unzip $filename -d "${INSTALL_PATH}"

echo "Done installing tflint"
echo "========================="

echo "install trivy"
TRIVY_VERSION="0.47.0"
curl --retry 3 --retry-delay 5 -sSL "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz" | sudo tar xz -C /usr/local/bin --overwrite

echo "Done install trivy"
echo "========================="

echo "run pre-commit"
pre-commit run --all-files
echo "Done running pre-commit"
echo "========================="
