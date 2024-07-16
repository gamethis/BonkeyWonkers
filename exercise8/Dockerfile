FROM node:bookworm

# Force apt to not be interactive. We don't need it to prompt us since we already know what we want to install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y  --no-install-recommends \
    ssh \
    gawk \
    curl \
    jq \
    yq \
    wget \
    sudo \
    gnupg-agent \
    ca-certificates \
    software-properties-common \
    apt-transport-https \
    libyaml-0-2 \
    zstd \
    zip \
    unzip \
    gnupg \
    xz-utils \
    gh \
    && rm -rf /var/lib/apt/lists/*


# Add the repository to Apt sources:
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker GPG key and repository
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends docker-ce-cli
# add sudo
RUN useradd -m -s /bin/bash -G sudo -p $(openssl passwd -1 password) bonkey
# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER bonkey
