#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$HOME/.myenv
. $BASE_DIR/lib/package/dpkg.bashrc

if sudo systemctl is-active docker >/dev/null 2>&1; then
  echo "[info] docker is already installed and active. Quit."
  exit 0
fi

# Prepare apt repository
sudo apt-get update
install_pkg apt-transport-https ca-certificates
sudo apt-key adv \
  --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo sh -c \
  "echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get purge lxc-docker

install_pkg linux-image-extra-$(uname -r)

install_pkg docker-engine

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-docker.sh> - 

=head1 SYNOPSYS

    setup-docker.sh

=head1 DESCRIPTION

blah blah blah.

=head1 AUTHORS

YASUTAKE Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

