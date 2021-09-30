# To run this file execute:
# docker build -f <Path to this file> <Path to Lunarvim basedir> -t Lunarvim:local

FROM ubuntu:latest

# Set environment correctly
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:/root/.cargo/bin:/root/.npm-global/bin${PATH}"

# Copy in local directory
COPY --chown=root:root . /LunarVim

# Install dependencies and LunarVim
RUN apt update && \
  apt -y install sudo curl build-essential git fzf python3-dev python3-pip cargo && \
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt update && \
  apt -y install nodejs && \
  apt clean && rm -rf /var/lib/apt/lists/* /tmp/* && \
  /LunarVim/utils/installer/install-neovim-from-release && \
  /LunarVim/utils/installer/install.sh --local --no-install-dependencies

# Setup LVIM to run on starup
ENTRYPOINT ["/bin/bash"]
CMD ["lvim"]

# vim: ft=dockerfile:
