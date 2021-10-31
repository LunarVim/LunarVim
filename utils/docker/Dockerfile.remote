# To run this file execute:
# docker build -f Dockerfile.remote . -t Lunarvim:remote

FROM ubuntu:latest

# Build argument to point to correct branch on GitHub
ARG LV_BRANCH=rolling

# Set environment correctly
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:/root/.cargo/bin:/root/.npm-global/bin${PATH}"

# Install dependencies and LunarVim
RUN apt update && \
  apt -y install sudo curl build-essential git fzf python3-dev python3-pip cargo && \
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt update && \
  apt -y install nodejs && \
  apt clean && rm -rf /var/lib/apt/lists/* /tmp/* && \
  curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install-neovim-from-release | bash && \
  LV_BRANCH=${LV_BRANCH} curl -LSs https://raw.githubusercontent.com/lunarvim/lunarvim/${LV_BRANCH}/utils/installer/install.sh | bash -s -- --no-install-dependencies

# Setup LVIM to run on starup
ENTRYPOINT ["/bin/bash"]
CMD ["lvim"]

# vim: ft=dockerfile:
