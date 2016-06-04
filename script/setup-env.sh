#!/usr/bin/env bash

set -euo pipefail

script_dir=${0%/*}
BASE_DIR="$(cd ${script_dir}/..; pwd)"
. $BASE_DIR/lib/setup.bashrc

echo "[START] setup $MYENV"

init

THE_ENV_DIR="$BASE_DIR/envs/$MYENV"
env_setup_script="$THE_ENV_DIR/script/setup.shrc"

if [[ -x $env_setup_script ]]; then
  . $env_setup_script
else
  echo "No setup script for env: $MYENV"
fi

echo "[END] setup $MYENV"

exit
