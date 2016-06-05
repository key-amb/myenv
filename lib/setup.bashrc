BASE_DIR=${BASE_DIR:-$HOME/my/repos/myenv}
PROJ_DIR=$HOME/.myenv

CUSTOM_RC_DIR=""
case "$SHELL" in
  */bash )
    CUSTOM_RC_DIR="${HOME}/.bashrc.d" ;;
  */zsh )
    CUSTOM_RC_DIR="${HOME}/.zshrc.d" ;;
  * )
    ;;
esac

init_proj_dir() {
  if [[ -e $PROJ_DIR ]]; then
    echo "[info] ${PROJ_DIR} exists"
  else
    ln -s $BASE_DIR $PROJ_DIR
    echo "[ok] linked. $PROJ_DIR -> $BASE_DIR"
  fi
}

mk_custom_rc_dir() {
  if [[ "$CUSTOM_RC_DIR" ]]; then
    mkdir -p $CUSTOM_RC_DIR
    echo "[ok] mkdir $CUSTOM_RC_DIR"
  fi
}

init() {
  init_proj_dir
  mk_custom_rc_dir
}

LINKER="$BASE_DIR/submodule/bash-links/links --verbose"
if [[ ${LINKS_FORCE:-} ]]; then
  LINKER="${LINKER} --force"
fi

symlink() {
  local src="${THE_ENV_DIR}/${1}";
  local link="${HOME}/$1"
  $LINKER $src $link
}

symlink2() {
  local src=$THE_ENV_DIR/$1
  local link=$2
  $LINKER $src $link
}
