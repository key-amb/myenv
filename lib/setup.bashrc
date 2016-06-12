BASE_DIR=${BASE_DIR:-$HOME/my/repos/myenv}
PROJ_DIR=$HOME/.myenv
THE_ENV_DIR="$PROJ_DIR/envs/$MYENV"

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

sync_file() {
  local src=$THE_ENV_DIR/$1
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

pre_exec_script() {
  [[ -z ${MYENV:-} ]] && return
  local pre_script="$PROJ_DIR/envs/$MYENV/script/pre-$(basename $0)"
  [[ ! -x $pre_script ]] && return
  $pre_script
}
