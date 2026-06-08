FROM mcr.microsoft.com/devcontainers/universal:2

# The base image ships a Yarn apt source whose signing key has rotated, so
# `apt-get update` fails ("NO_PUBKEY 62D54FD4003F6525 / repository is not
# signed"). That breaks any dev-container Feature that runs apt-get update
# during the build (e.g. the terraform Feature). Yarn isn't used by these
# exercises, so remove the source — both a dedicated *.list and any inline
# entry — so apt-get update succeeds before Features install.
RUN rm -f /etc/apt/sources.list.d/yarn.list \
 && sed -i '\|dl\.yarnpkg\.com|d' /etc/apt/sources.list 2>/dev/null || true
