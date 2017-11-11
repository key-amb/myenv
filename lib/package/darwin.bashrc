# bash

install_pkg() {
  local _pkg
  for _pkg in $@; do
    if ! (brew list $_pkg >/dev/null 2>&1); then
      brew install $_pkg
    else
      echo "[info] $_pkg already installed"
    fi
  done
}
