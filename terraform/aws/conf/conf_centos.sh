#!/bin/bash
#
# Author: @theDevilsVoice
# Date: 09/08/2017
#
# Script Name: conf_centos.sh
#
# Description: Use this shell script to ensure your system
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile
#

# Configure the storage we created
function config_storage {

  mount="/data1"
  if ! grep -qs "$mount" /proc/mounts
  then
    mkfs -t ext4 /dev/xvdf
    mkdir ${mount}
    mount /dev/xvdf ${mount}
  fi

}

function fix_etc_hosts {

  #   Find the IPv4 address of puppet master
  yum install -y bind-utils
  PUPPET_MASTER_IP=$(/usr/bin/host puppet.bitsmasher.net | grep "has address" | head -1 | awk '{print $NF}')
  if ! grep -Fxq "${PUPPET_MASTER_IP} puppet puppet.bitsmasher.net" /etc/hosts
  then
    echo "${PUPPET_MASTER_IP} puppet puppet.bitsmasher.net" >> /etc/hosts
  fi

} # // fix_etc_hosts

# Fix up puppet.conf
function fix_puppet_config {

  CFG="/etc/puppetlabs/puppet/puppet.conf"
  sed -i '/main/a      server=puppet' ${CFG}
  sed -i '/main/a      preferred_serialization_format =  msgpack' ${CFG}

} # //fix_puppet_config

function fix_ruby {

  CFG="/etc/puppetlabs/puppet/puppet.conf"
  echo "gem: --no-document" > ~/.gemrc
  yum install -y git-core zlib zlib-devel gcc-c++ patch readline
  yum install -y readline-devel libyaml-devel openssl-devel make bzip2
  yum install -y autoconf automake libtool bison curl sqlite-devel
  cd
  git clone git://github.com/sstephenson/rbenv.git .rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  exec $SHELL
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
  exec $SHELL
  rbenv install -v 2.3.0
  rbenv global 2.3.0
  # let puppet install the gems yo
  #gem install puppet-lint
  #gem install msgpack
  sed -i '/main/a      preferred_serialization_format =  msgpack' ${CFG}

} # //fix_ruby

function main {

  # Make sure we have privs
  if [[ $EUID -ne 0 ]]
  then
   echo "This script must be run as root" 
   exit 1
  fi

  config_storage
  fix_etc_hosts
  yum -y install epel-release
  #fix_ruby
  fix_puppet_config

  # fix up selinux
  sed -i 's,^\(SELINUX=\).*,\1'permissive',' /etc/selinux/config
  setenforce 0

  # This command might not work the first (or even second) time. 
  # Might need to do manually
  /opt/puppetlabs/bin/puppet agent -t --verbose --debug 

  /opt/puppetlabs/puppet/bin/gem install msgpack 

  # double check dat ufw (obsoleted by security.tf)
  #ufw allow 8140

  /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

}

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi
