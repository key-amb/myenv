LOCAL_REPOS=(
  $HOME/.dotfiles
  $HOME/.myenv
  $HOME/.basher
  $HOME/my/repos/tech-notes
)

for _repo in .clenv .basher; do
  if [[ -d "$HOME/${_repo}" ]]; then
    LOCAL_REPOS+=($HOME/${_repo})
  fi
done

check_brew_update() {
  local tsfile="${TMPD}/Homebrew.${YMD}"
  local tmpfile="${HOMEBREW_PREFIX}/var/homebrew/.tmp"
  if ! touch $tmpfile &>/dev/null; then
    echo "[info] Not the Homebrew manager. Skip."
    return
  fi
  if [[ $FORCE || ! -e $tsfile ]]; then
    brew update
    brew outdated
    brew bundle check --global || true # not to fail
    brew bundle cleanup --global
    rm -f "$TMPD/Homebrew.*"
    touch $tsfile
  fi
  rm $tmpfile
}

update_local_env() {
  if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
    check_brew_update
  fi
}
