FROM ubuntu:20.04

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8
ENV TERM screen-256color
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
  git \
  bash \
  fzf \
  wget \
  python3-dev \
  python3-pip \
  libssl-dev \
  libffi-dev \
  locales \
  curl \
  ripgrep \
  nodejs \
  npm \
  neovim

SHELL ["/bin/bash", "-c"]

RUN npm i -g neovim
RUN bash  <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/nvim/master/utils/install-docker.sh)
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

CMD ["nvim"]





