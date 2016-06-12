#!/usr/bin/env bash

set -euo pipefail

BASE_DIR=$HOME/.myenv
. $BASE_DIR/lib/package/dpkg.bashrc

if sudo systemctl is-active dnsmasq >/dev/null 2>&1; then
  echo "[info] dnsmasq is already installed and active. Quit."
  exit 0
fi

install_pkg dnsmasq
# Stop to reconfigure
sudo systemctl stop dnsmasq

# Reconfigure and restart network-manager
NM_CONF="/etc/NetworkManager/NetworkManager.conf"
if egrep '^dns=dnsmasq$' $NM_CONF >/dev/null 2>&1; then
  sudo perl -pi -e 's/^(dns=dnsmasq)$/#$1/g' $NM_CONF
fi
sudo systemctl stop network-manager
sleep 2
sudo pkill dnsmasq && sleep 1 # Just in case
sudo systemctl start network-manager
sleep 1

# Launch dnsmasq
sudo systemctl start dnsmasq

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<replace-netman-dnsmasq> - summary

=head1 SYNOPSYS

    replace-netman-dnsmasq [options ...]

=head1 DESCRIPTION

Disable default dnsmasq which is bundled with NetworkManager.

=head1 SEE ALSO

L<https://sites.google.com/site/keyambwebtech/home/memorandom/20160612#TOC-Ubuntu-16.04-dnsmasq->

=head1 AUTHORS

YASUTAKE Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=cut

__EOF__

