#!/bin/sh -eux

echo 'export PATH="/opt/puppetlabs/bin:$PATH"' > /etc/profile.d/puppet4.sh;

echo "Installing Puppet Agent packages...";
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install puppet-agent=$AGENT_VERSION-1$OS_NAME;

echo "Installing Puppet Server packages...";
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install puppetserver=$SERVER_VERSION-1puppetlabs1;
echo "setting memory requirements for puppetserver to a reasonable value";
sed -i "s/Xms[0-9]+[gm]/Xms512m/g" /etc/default/puppetserver;
sed -i "s/Xmx[0-9]+[gm]/Xmx512m/g" /etc/default/puppetserver;
sed -i "s/MaxPermSize\=[0-9]+[gm]/MaxPermSize\=128m/g" /etc/default/puppetserver;

echo "Installing PuppetDB packages...";
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install puppetdb=$PUPPETDB_VERSION-1puppetlabs1;

echo "Installing PuppetDB terminus packages...";
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install puppetdb-termini=$PUPPETDB_VERSION-1puppetlabs1;

echo "Installing Git";
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" install git;

echo "Installing hiera-eyaml, hiera-eyaml-gpg and ruby_gpg for puppetserver";
/opt/puppetlabs/bin/puppetserver gem install ruby_gpg -v ">=0.3.1";
/opt/puppetlabs/bin/puppetserver gem install hiera-eyaml hiera-eyaml-gpg;
echo "hiera-eyaml installed!";

echo "Installing R10K for puppetserver";
/opt/puppetlabs/bin/puppetserver gem install r10k -v $R10K_VERSION;
echo "R10K installed!";
