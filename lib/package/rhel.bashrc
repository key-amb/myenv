# bash

install_pkg() {
  local _pkg
  for _pkg in $@; do
    if ! (rpm -q $_pkg >/dev/null 2>&1); then
      sudo yum install -y $_pkg
    else
      echo "[info] $_pkg already installed"
    fi
  done
}
