LOCAL_REPOS=(
  $HOME/dotfiles
  $HOME/.myenv
  $HOME/.clenv
)

tsfile="$TMPD/Homebrew.$YMD"
if [[ $FORCE || ! -e $tsfile ]]; then
  brew update
  brew outdated
  rm -f "$TMPD/Homebrew.*"
  touch $tsfile
fi
