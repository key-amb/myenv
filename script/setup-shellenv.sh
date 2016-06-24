#!/usr/bin/env bash

set -euo pipefail

script_dir=${0%/*}
BASE_DIR="$(cd ${script_dir}/..; pwd)"
. $BASE_DIR/lib/setup.bashrc

echo "[START] setup $MYENV"

init_shell

env_setup_script="$THE_ENV_DIR/script/setup-shell.shrc"

if [[ -r $env_setup_script ]]; then
  . $env_setup_script
else
  echo "No setup script for env: $MYENV"
fi

echo "[END] setup $MYENV"

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-shellenv.sh> - Script to set up a shell environment

=head1 SYNOPSYS

    MYENV=<target env> script/setup-shellenv.sh

=head1 DESCRIPTION

This script set up a shell environment for current user.

=head1 SEE ALSO

L<script/setup-env.sh>

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

