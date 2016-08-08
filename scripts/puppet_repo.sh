#!/bin/sh -eux

echo 'export PATH="/opt/puppetlabs/bin:$PATH"' > /etc/profile.d/puppet4.sh;

REPO_NAME="puppetlabs-release-"$COLLECTION"-$OS_NAME";

echo "installing colection repo";
wget http://apt.puppetlabs.com/$REPO_NAME.deb;
dpkg -i $REPO_NAME.deb;
echo "Update APT...";
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update >/dev/null;

rm $REPO_NAME.deb;
