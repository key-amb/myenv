# bash
# Library for common/bin/update-local-repos

TMPD=$HOME/tmp/$PROG

# lock & unlock
LOCK_DIR=$TMPD/lock.d
MAX_RETRY=5
SLEEP=6

get_lock() {
  local retry=0
  while true; do
    if mkdir $LOCK_DIR &>/dev/null; then
      if ((retry > 0)); then
        echo "[info] Succeeded to get lock."
      fi
      return 0
    fi
    ((++retry > MAX_RETRY)) && break
    echo "[notice] Failed to get lock. Retrying ... (${retry})"
    sleep $SLEEP
  done

  echo "[warn] Retry failed! Abort!"
  return 1
}

unlock() {
  rmdir $LOCK_DIR
}

cleanup_tmpdir() {
  find $TMPD -mtime +3 -exec rm -f {} \;
}

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
