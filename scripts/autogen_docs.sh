#!/usr/bin/env bash
set -ex

lvim -E -R --headless \
  --cmd "set rtp+=$PWD" \
  +"luafile scripts/autogen_docs.lua" +q
