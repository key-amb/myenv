#!/usr/bin/env bash

set -euo pipefail

REPOS_DIR=$HOME/gitrepos
DF_REPO=$HOME/gitrepos/dotfiles
SETUP_SCRIPTS=(
  setup-all-links.sh
  setup-vim-env.sh
  set-custom-shrc-links.sh
)

mkdir -p $REPOS_DIR

if [[ ! -d $DF_REPO ]]; then
  git clone git@github.com:key-amb/dotfiles.git $DF_REPO
fi

cd $DF_REPO
git pull origin master
git submodule update --init

DF_OPTS=""
if [[ ${DF_SHELL:-} ]]; then
  DF_OPTS="env SHELL=${DF_SHELL}"
fi
for _script in ${SETUP_SCRIPTS[@]}; do
  $DF_OPTS script/$_script
done

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-dotfiles> - Script to bootstrap dotfiles

=head1 SYNOPSYS

    setup-dotfiles
    DF_SHELL=/bin/zsh setup-dotfiles

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__
