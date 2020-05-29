# bash

if [[ -z ${BASE_DIR:-} ]]; then
  BASE_DIR=$(cd $(dirname $BASH_SOURCE)/.. && pwd)
fi
REPO_BASE=$(cd $BASE_DIR/.. && pwd)
PROJ_DIR=$HOME/.myenv
DOTS_ENV_DIR="$PROJ_DIR/envs/$DOTS_ENV"

DOTS_ROOT=${DOTS_ROOT:-$HOME/.dotfiles}

init_proj_dir() {
  if [[ -e $PROJ_DIR ]]; then
    echo "[info] ${PROJ_DIR} exists"
  else
    ln -s $BASE_DIR $PROJ_DIR
    echo "[ok] linked. $PROJ_DIR -> $BASE_DIR"
  fi
}

LINKER="${BASE_DIR}/submodule/bash-links/links --verbose"
if [[ -n "${LINKS_FORCE:-}" ]]; then
  LINKER="${LINKER} --force"
fi

symlink() {
  local src="${DOTS_ENV_DIR}/${1}";
  local link="${HOME}/$1"
  local _dir="${1%/*}"
  if [[ "$_dir" != "$1" ]]; then
    mkdir -p "$HOME/${_dir}"
    echo "[ok] mkdir $HOME/${_dir}"
  fi
  $LINKER $src $link
}

symlink2() {
  local src=$DOTS_ENV_DIR/$1
  local link=$2
  $LINKER $src $link
}

sync_file() {
  local src=$DOTS_ENV_DIR/$1
  local dst=$2
  local dst_dir=${dst%/*}
  local sync_opts=""
  if [[ ${SUDO_SYNC:-} ]]; then
    sync_opts="sudo"
  fi
  $sync_opts mkdir -p $dst_dir
  if $sync_opts diff -u -s $src $dst; then
    return
  fi
  $sync_opts cp $src $dst && echo "cp $src $dst"
}
