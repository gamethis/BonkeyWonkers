# Legacy Setup Instructions

This document contains installation instructions that were previously included
in `code_space.sh` as commented code. These instructions are preserved here
for reference and manual installation if needed.

## Table of Contents

- [Terraform Docs Installation](#terraform-docs-installation)
- [Terraform Installation](#terraform-installation)
- [Vault Installation](#vault-installation)
- [ACT (GitHub Actions Local Runner) Setup](#act-github-actions-local-runner-setup)
- [Additional Notes](#additional-notes)

## Terraform Docs Installation

```bash
# Install Terraform Docs
TFDOCS_VERSION=0.18.0
sudo go install github.com/terraform-docs/terraform-docs@v${TFDOCS_VERSION}
echo "Done Installing Terraform Docs"
```

## Terraform Installation

```bash
# Install Terraform via HashiCorp APT repository
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Terraform
sudo apt-get update -y
sudo apt-get install terraform -y
terraform --version
echo "Done Installing Terraform"
```

## Vault Installation

### Vault Version Function

```bash
function getLatestVaultVersion() {
  LATEST_ARR=($(wget -q -O- \
    https://api.github.com/repos/hashicorp/vault/releases 2> /dev/null | \
    awk '/tag_name/ { print $2 }' | cut -d '"' -f 2 | cut -d 'v' -f 2))

  for ver in "${LATEST_ARR[@]}"; do
    if [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]]; then
      LATEST="$ver"
      break
    fi
  done
  echo -n "$LATEST"
}
```

### Vault Installation Steps

```bash
# Install Vault
echo "Install Vault"

VAULT_VERSION=$(getLatestVaultVersion)

cd ~
wget "https://releases.hashicorp.com/vault/"$VAULT_VERSION"/vault_"$VAULT_VERSION"_linux_amd64.zip"
unzip -o "vault_"$VAULT_VERSION"_linux_amd64.zip"
sudo install vault /usr/local/bin/
pip3 install hvac
```

## ACT (GitHub Actions Local Runner) Setup

### Manual ACT Installation

```bash
# Download and install ACT
wget https://github.com/nektos/act/releases/latest/download/act_Linux_x86_64.tar.gz
sudo tar -xvlsf act_Linux_x86_64.tar.gz -C /usr/local/bin act
act --version
rm -rf act_Linux_x86_64.tar.gz
```

### Local Container Setup for ACT

```bash
# Clone demo repository
git clone https://github.com/cplee/github-actions-demo.git

# Build container for using ACT locally
echo "Building container for using act local"
docker build --platform linux/amd64 -t act-local .
docker tag act-local:latest localhost:5000/act-local:latest

# Push container to local registry
echo "Pushing container to local registry"
docker image push localhost:5000/act-local:latest

# Configure ACT to use local container
echo "Configuring act to use local container"
cat <<EOF > ~/.actrc
-P ubuntu-latest=localhost:5000/act-local:latest
EOF

# Set Docker host environment variable
export DOCKER_HOST=$(docker context inspect --format '{{.Endpoints.docker.Host}}')

# Test ACT installation
echo "testing act"
echo | act -C github-actions-demo

# Cleanup
rm -rf github-actions-demo
echo "Returning to main path"
cd /workspaces/BonkeyWonkers/
```

### Environment Variable Setup

```bash
# Add Docker host to bashrc (commented in original)
# echo 'export DOCKER_HOST=$(docker context inspect --format \
#   '\''{{.Endpoints.docker.Host}}'\'')' >> ~/.bashrc
```

## Additional Notes

### Purpose of These Instructions

These installation steps were previously included in the `code_space.sh`
provisioning script but were commented out, likely because:

1. **Development Environment**: The dev container already includes these tools
   pre-installed
2. **Performance**: Avoiding redundant installations during container startup
3. **Maintenance**: Tools are managed through the dev container configuration
   instead

### When to Use These Instructions

- **Manual Installation**: If you need to install these tools in a different
  environment
- **Troubleshooting**: If tools are missing or need to be reinstalled
- **Local Development**: Setting up a local development environment outside
  of the dev container
- **Custom Environments**: Adapting the setup for different platforms or
  configurations

### Version Considerations

Note that the versions specified in these instructions may be outdated.
Always check for the latest versions when performing manual installations:

- Terraform Docs: Check [releases](https://github.com/terraform-docs/terraform-docs/releases)
- Terraform: Check [HashiCorp releases](https://releases.hashicorp.com/terraform/)
- Vault: Check [HashiCorp releases](https://releases.hashicorp.com/vault/)
- ACT: Check [nektos/act releases](https://github.com/nektos/act/releases)

### Related Files

- `/workspaces/BonkeyWonkers/.devcontainer/code_space.sh` - Current
  provisioning script
- `/workspaces/BonkeyWonkers/.devcontainer/devcontainer.json` - Dev container
  configuration
- Various exercise READMEs for tool-specific usage instructions
