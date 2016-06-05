#!/usr/bin/env bash

set -euo pipefail

script_dir=${0%/*}
BASE_DIR="$(cd ${script_dir}/..; pwd)"
. $BASE_DIR/lib/setup.bashrc

echo "[START] setup $MYENV"

init

THE_ENV_DIR="$PROJ_DIR/envs/$MYENV"
env_setup_script="$THE_ENV_DIR/script/setup.shrc"

if [[ -x $env_setup_script ]]; then
  . $env_setup_script
else
  echo "No setup script for env: $MYENV"
fi

echo "[END] setup $MYENV"

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-env.sh> - Script to set up environments

=head1 SYNOPSYS

    MYENV=<target env> script/setup-env.sh

Optional Shell Variables:

    LINKS_FORCE=1 # force replace existing symlinks
                  # See also: https://github.com/key-amb/bash-links

=head1 DESCRIPTION

This script set up environments.

=head1 AUTHORS

YASUTAKE Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
