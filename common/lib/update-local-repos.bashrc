# bash

# update clenv/clam modules
update_clam_modules() {
  tsfile="$TMPD/clam-modules.$YMD"
  if [[ $FORCE || ! -e $tsfile ]]; then
    clam -r $HOME/.myenv/common/Clamfile
    rm -f "$TMPD/clam-modules.*"
    touch $tsfile
  fi
}

# check if basher packages outdated
check_basher_outdated() {
  local tsfile="${TMPD}/basher.${YMD}"
  if [[ $FORCE || ! -e $tsfile ]]; then
    basher outdated
    rm -f "$TMPD/basher.*"
    touch $tsfile
  fi
}
