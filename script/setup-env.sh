#!/usr/bin/env bash

set -euo pipefail

script_dir=${0%/*}
BASE_DIR="$(cd ${script_dir}/..; pwd)"
. $BASE_DIR/lib/setup.bashrc

echo "[START] setup $MYENV"

init

env_setup_script="$BASE_DIR/envs/$MYENV/script/setup.shrc"

if [[ -x $env_setup_script ]]; then
  . $env_setup_script
else
  echo "No setup script for env: $MYENV"
fi

echo "[END] setup $MYENV"

exit
