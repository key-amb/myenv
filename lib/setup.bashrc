if [[ -z ${BASE_DIR:-} ]]; then
  BASE_DIR=$(cd $(dirname $BASH_SOURCE)/.. && pwd)
fi
REPO_BASE=$(cd $BASE_DIR/.. && pwd)
PROJ_DIR=$HOME/.myenv
THE_ENV_DIR="$PROJ_DIR/envs/$MYENV"

DOTS_ROOT=${DOTS_ROOT:-$HOME/.dotfiles}

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

init_shell() {
  init_proj_dir
  mkdir -p "$HOME/bin"
  mk_custom_rc_dir
}

LINKER="$BASE_DIR/submodule/bash-links/links --verbose"
if [[ ${LINKS_FORCE:-} ]]; then
  LINKER="${LINKER} --force"
fi

symlink() {
  local src="${THE_ENV_DIR}/${1}";
  local link="${HOME}/$1"
  local _dir="${1%/*}"
  if [[ "$_dir" != "$1" ]]; then
    mkdir -p "$HOME/${_dir}"
    echo "[ok] mkdir $HOME/${_dir}"
  fi
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

change_shell_to() {
  local target=$1
  if [[ ! -x $target ]]; then
    echo "[error] $target not executable!"
    return 1
  fi
  if [[ "$(basename $target)" = "$(basename $SHELL)" ]]; then
    echo "[notice] Already using $(basename $target). Skip."
    return
  fi
  sudo chsh -s $target
}

UD_LINK_TARGETS=()
setup_symlinks() {
  local _lt
  for _lt in "${UD_LINK_TARGETS[@]}"; do
    symlink $_lt
  done
}

setup_dotfiles() {
  local df_shell=
  [[ $SETUP_SHELL = "zsh" ]] && df_shell=/bin/zsh
  DF_SHELL=${df_shell} $BASE_DIR/script/setup-dotfiles.sh
}

setup_basher() {
  source $DOTS_ROOT/lib/basher.bashrc
  if [[ ! -d $HOME/.basher ]]; then
    git clone https://github.com/basherpm/basher.git $HOME/.basher
    source $DOTS_ROOT/shrc.d/load_basher.shrc
  fi
  basher_bundle_install
}

setup_clenv() {
  if [[ ! -d $HOME/.clenv ]]; then
    git clone git@github.com:progrhyme/clenv.git $HOME/.clenv
    source $DOTS_ROOT/shrc.d/load_clenv.shrc
  fi
  clam -r $DOTS_ROOT/etc/Clamfile
}

setup_ohmyzsh() {
  local ohmyzsh=$HOME/.oh-my-zsh
  local ohmyzsh_custom_plugins=(
    https://github.com/zsh-users/zsh-autosuggestions
  )
  local git_uri _basename _plugin_dir

  if [[ ! -d $ohmyzsh ]]; then
    # Install oh-my-zsh
    curl -Lo /tmp/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    RUNZSH=no sh /tmp/install.sh
  fi

  for git_uri in "${ohmyzsh_custom_plugins[@]}"; do
    _basename=${git_uri##*/}
    _basename=${_basename%.git}
    _plugin_dir="${ohmyzsh}/custom/plugins/${_basename}"
    if [[ ! -d $_plugin_dir ]]; then
      git clone $git_uri $_plugin_dir
    fi
  done
}
