FROM ubuntu:latest

ARG NEOVIM_RELEASE=v0.5.0
ARG LVBRANCH=rolling

ENV DEBIAN_FRONTEND=noninteractive

# Install apt dependencies
RUN apt update && \
  apt -y install sudo curl build-essential git fzf python3-dev python3-pip cargo && \
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
  apt update && \
  apt -y install nodejs && \
  curl -L -o /tmp/nvim.appimage https://github.com/neovim/neovim/releases/download/${NEOVIM_RELEASE}/nvim.appimage && \
  chmod u+x /tmp/nvim.appimage && \
  /tmp/nvim.appimage --appimage-extract && \
  mv squashfs-root /usr/local/neovim && \
  ln -s /usr/local/neovim/usr/bin/nvim /usr/bin/nvim && \
  apt clean && rm -rf /var/lib/apt/lists/* /tmp/* && \
  LVBRANCH=${LVBRANCH} curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh | bash -s -- -y

ENV PATH="/root/.local/bin:/root/.cargo/bin:/root/.npm-global/bin${PATH}"

ENTRYPOINT ["/bin/bash"]
CMD ["lvim"]
