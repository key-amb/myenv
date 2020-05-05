LOCAL_REPOS=(
  $HOME/.dotfiles
  $HOME/.myenv
  $HOME/.clenv
  $HOME/my/repos/tech-notes
)

check_brew_update() {
  local tsfile="$TMPD/Homebrew.$YMD"
  local tmpfile="/usr/local/var/homebrew/.tmp"
  if ! touch $tmpfile &>/dev/null; then
    echo "[info] Not the Homebrew manager. Skip."
    return
  fi
  if [[ $FORCE || ! -e $tsfile ]]; then
    brew update
    brew outdated
    rm -f "$TMPD/Homebrew.*"
    touch $tsfile
  fi
  rm $tmpfile
}

check_brew_update
