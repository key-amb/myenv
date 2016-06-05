#!/usr/bin/env bash

install_pkg() {
  for _pkg in $@; do
    if !(dpkg-query -l $_pkg >/dev/null 2>&1); then
      sudo apt-get install -y $_pkg
    else
      echo "[info] $_pkg already installed"
    fi
  done
  unset _pkg
}
