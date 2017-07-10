#!/usr/bin/env bash

set -euo pipefail

base_dir="$(cd $(dirname $0)/..; pwd)"
. $base_dir/lib/setup.bashrc

echo "[START] setup $MYENV"

init_proj_dir

env_setup_script="$THE_ENV_DIR/script/setup.shrc"

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

B<setup-env.sh> - Script to set up environments

=head1 SYNOPSYS

    MYENV=<target env> script/setup-env.sh

Optional Shell Variables:

    LINKS_FORCE=1 # force replace existing symlinks
                  # See also: https://github.com/progrhyme/bash-links

=head1 DESCRIPTION

This script set up environments.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
