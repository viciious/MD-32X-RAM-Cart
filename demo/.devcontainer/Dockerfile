# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.231.6/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN sudo apt update && apt install -y curl zstd make jq

RUN curl -sL --fail -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/viciious/32XDK/releases/tags/20190504" \
    | jq -r ".assets | .[] | select(.name | test(\"chillys-sega-devkit-20190504-opt.tar.zst$\")) | .url" \
    | xargs curl -sL --fail -H "Accept: application/octet-stream" -O /dev/stdout | zstdcat | tar -C / -xa

RUN sudo apt -y install genisoimage
