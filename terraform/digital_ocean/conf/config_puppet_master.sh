#!/bin/bash
#
# Description: Set up and start puppet master
# Author: Frank The Tank

# avoid conflict with apache2 
systemctl stop apache2

# ensure you have the latest versionof puppet
puppet resource package puppetmaster ensure=latest

sed '9 a  dns_alt_names=puppet.bitsmasher.net' /etc/puppet/puppet.conf

# 
systemctl restart puppetmaster

#
if [ ! -d  /etc/puppet/modules/accounts ] ; then
  mkdir -p /etc/puppet/modules/accounts
fi

if [ ! -d /etc/puppet/modules/accounts/examples ] ; then
  mkdir /etc/puppet/modules/accounts/examples
fi 

if [ ! -d /etc/puppet/modules/accounts/files ] ; then 
  mkdir /etc/puppet/modules/accounts/files
fi 

if [ ! -d /etc/puppet/modules/accounts/manifests ] ; then
  mkdir /etc/puppet/modules/accounts/manifests
fi 

if [ ! -d /etc/puppet/modules/accounts/templates ] ; then
  mkdir /etc/puppet/modules/accounts/templates
fi

cat << EOF > /etc/puppet/modules/accounts/manifests/groups.pp
class accounts::groups {
        
  group { 'engr':
    ensure  => present,
  }
          
}
EOF

#git config --global color.ui true
#git config --global user.name "YOUR NAME"
#git config --global user.email "YOUR@EMAIL.com"
echo "gem: --no-document" > ~/.gemrc
gem install puppet-lint
