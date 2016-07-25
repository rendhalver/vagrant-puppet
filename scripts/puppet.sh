#!/usr/bin/env bash

set -e

echo 'export PATH="/opt/puppetlabs/bin:$PATH"' > /etc/profile.d/puppet4.sh

echo "Installing Puppet Agent packages..."
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install puppet-agent=$AGENT_VERSION-1$OS_NAME
