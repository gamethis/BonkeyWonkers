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
unzip -o  "terraform_"$VERSION"_linux_amd64.zip"
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
sudo unzip -o  $filename -d "${INSTALL_PATH}"

echo "Done installing tflint"
echo "========================="

echo "install trivy"
TRIVY_VERSION="0.49.0"
curl --retry 3 --retry-delay 5 -sSL "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz" | sudo tar xz -C /usr/local/bin --overwrite

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

echo "Get stress test"
docker pull j0hnewhitley/docker-stress:v0.0.1

echo "============"

echo "Setting up Vault"

function getLatestVaultVersion() {

  LATEST_ARR=($(wget -q -O- https://api.github.com/repos/hashicorp/vault/releases 2> /dev/null | awk '/tag_name/ { print $2 }' | cut -d '"' -f 2 | cut -d 'v' -f 2))

  for ver in "${LATEST_ARR[@]}"; do
    if [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]]; then
      LATEST="$ver"
      break
    fi
  done
  echo -n "$LATEST"
}

echo "Install Vault"

VAULT_VERSION=$(getLatestVaultVersion)

cd ~
wget "https://releases.hashicorp.com/vault/"$VAULT_VERSION"/vault_"$VAULT_VERSION"_linux_amd64.zip"
unzip -o  "vault_"$VAULT_VERSION"_linux_amd64.zip"
sudo install vault /usr/local/bin/

echo "============"

echo "Install ACT"
cd /workspaces/BonkeyWonkers/exercise6
git clone https://github.com/nektos/act.git
# cd act
# sudo make test
# sudo make install
wget https://github.com/nektos/act/releases/latest/download/act_Linux_x86_64.tar.gz
sudo tar -xvlsf act_Linux_x86_64.tar.gz -C /usr/local/bin act
act --version

# cd ..
# rm -rf act
rm -rf act_Linux_x86_64.tar.gz
git clone https://github.com/cplee/github-actions-demo.git
echo "Building container for using act local"
docker build -t act-local .
docker tag act-local:latest localhost:5000/act-local:latest
echo "Pushing container to local registry"
docker image push localhost:5000/act-local:latest
echo "Configuring act to use local container"
cat <<EOF > ~/.actrc
-P ubuntu-latest=localhost:5000/act-local:latest
EOF
echo 'export DOCKER_HOST=$(docker context inspect --format '\''{{.Endpoints.docker.Host}}'\'')' >> ~/.bashrc
export DOCKER_HOST=$(docker context inspect --format '\''{{.Endpoints.docker.Host}}'\')
echo "testing act"
echo | act -C github-actions-demo
echo "==========="
echo "Returning to main path"
cd /workspaces/BonkeyWonkers/


echo "Completed Setup"
exit 0
