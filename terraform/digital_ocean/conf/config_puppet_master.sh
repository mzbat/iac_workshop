#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 10/13/2017
#
# Script Name: config.sh
#
# Description: Set up and start puppet master
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile
#

# configure JAVA properties for puppetserver
# should we just copy in a modified file instead of so much sed
function fix_java {
  sed -e '/JAVA_ARGS/ s/^#*/#/' -i /etc/default/puppetserver
  LINE='JAVA_ARGS="-Xms3g -Xmx3g -XX:MaxPermSize=256m"'
  grep -qF "$LINE" /etc/default/puppetserver || echo "$LINE" >> /etc/default/puppetserver 
  return 0
}

# Fix puppet.conf
function fix_puppet {
  sed '9 a  dns_alt_names=puppet,puppet.bitsmasher.net' /etc/puppetlabs/puppet/puppet.conf
  sed -i '/master/a   autosign = /etc/puppetlabs/puppet/autosign.conf' /etc/puppetlabs/puppet/puppet.conf 
  echo '*' > /etc/puppetlabs/puppet/autosign.conf
  sed -i '/master/a   always_cache_features = true' /etc/puppetlabs/puppet/puppet.conf
  sed -i '/main/a      server = puppet.bitsmasher.net' /etc/puppetlabs/puppet/puppet.conf 
  # this is to stop the msgpack errors
  apt-get install -y ruby-msgpack
  sed -i '/main/a      preferred_serialization_format =  msgpack' /etc/puppetlabs/puppet/puppet.conf
  return 0
}

#####################################################
# fix webroutes bug 
# https://github.com/theforeman/puppet-puppet/issues/549
# https://tickets.puppetlabs.com/browse/SERVER-1876
#####################################################
function fix_webroutes {
  #/etc/puppetlabs/puppetserver/conf.d/web-routes.conf
  # must contian the line: 
  # "puppetlabs.trapperkeeper.services.metrics.metrics-service/metrics-webservice": "/metrics"
  sed -i '13i    # This controls the mount point for the metrics API' /etc/puppetlabs/puppetserver/conf.d/web-routes.conf
  sed -i '14i    "puppetlabs.trapperkeeper.services.metrics.metrics-service/metrics-webservice": "/metrics"' /etc/puppetlabs/puppetserver/conf.d/web-routes.conf
  # uncomment line in /etc/puppetlabs/puppetserver/services.d/ca.cfg
  sed -i '/trapperkeeper/s/^#//g' /etc/puppetlabs/puppetserver/services.d/ca.cfg
  return 0
}

# fix up the githubs
function fix_github {
  #git config --global color.ui true
  #git config --global user.name "YOUR NAME"
  #git config --global user.email "YOUR@EMAIL.com"
  return 0
}

function config_ruby {
  echo "gem: --no-document" > ~/.gemrc
  # need to install ruby first
  #apt-get install ruby-full -y
  /opt/puppetlabs/puppet/bin/gem install puppet-lint
  /opt/puppetlabs/puppet/bin/gem install rspec-puppet
  # cd into your module and do:
  # rspec-puppet-init
  return 0
}
 
function config_ntp {
  # set the time
  apt install ntpdate
  #ntpdate pool.ntp.org
  apt-get -y install ntp
  service ntp restart
  #timedatectl list-timezones
  timedatectl set-timezone America/Indiana/Indianapolis
  return 0
}

function main {
  fix_puppet
  fix_java
  fix_webroutes
  #fix_github
  config_ruby
  config_ntp

  # fire it up
  echo "Starting puppetserver... please be patient."
  echo "This will take about 3 minutes. "
  systemctl start puppetserver
  systemctl enable puppetserver
  #systemctl is-active puppetserver
  apt-get -y install "build-essential"
  /opt/puppetlabs/puppet/bin/gem install msgpack
  #/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
  bash /root/sync_git_master.sh -p
}

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi
