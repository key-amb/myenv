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

_symlink() {
  local src=$1
  local dest=$2

  if [ -L $dest ]; then
    local linked_read=$(readlink $dest)
    if [[ $linked_read = $src ]]; then
      echo "[ok] already linked: ${dest} -> ${src}";
    else
      echo "[warn] link different: ${dest} -> ${linked_read}. Expected: ${src}";
    fi
    return 0;
  elif [ -d $dest ]; then
    echo "[warn] directory already exists: $dest";
    return 0;
  elif [ -f $dest ]; then
    echo "[warn] file already exists: $dest";
    return 0;
  fi

  if [ -e $src ]; then
    ln -s $src $dest;
    echo "[ok] linked: $dest -> ${src}";
  else
    echo "[error] not exist: ${src}";
    return 1;
  fi

  return 0;
}

symlink() {
  local link="${HOME}/$1"
  local src="${PROJ_DIR}/${1}";
  _symlink $src $link
}

symlink2() {
  local src=$PROJ_DIR/$1
  local link=$2
  _symlink $src $link
}
