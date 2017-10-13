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
  mkdir /etc/puppet/modules/accounts/templates}
fi

cat << EOF > /etc/puppet/modules/accounts/manifests/init.pp
class accounts {
  
  include groups

  $rootgroup = $osfamily ? {
    'Debian'  => 'sudo',
    'RedHat'  => 'wheel',
    default   => warning('This distribution is not supported by the Accounts module'),
  }

  user { 'franklin':
    ensure      => present,
    home        => '/home/franklin',
    shell       => '/bin/bash',
    managehome  => true,
    gid         => 'engr',
    groups      => "$rootgroup",
    password    => '$1$eiZnsE6i$ikxFucK5yOH1syHqlY.l/1',
  }

  user { 'mzbat':
    ensure      => present,
    home        => '/home/mzbat',
    shell       => '/bin/bash',
    managehome  => true,
    gid         => 'engr',
    groups      => "$rootgroup",
  }


}
EOF

cat << EOF > /etc/puppet/modules/accounts/manifests/groups.pp
class accounts::groups {
        
  group { 'engr':
    ensure  => present,
  }
          
}
EOF
