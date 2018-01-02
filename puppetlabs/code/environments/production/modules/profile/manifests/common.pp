# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/common.pp
class profile::common {

  #package { 'puppet-lint':
  #  ensure   => 'installed',
  #  provider => 'gem',
  #}

  package { 'awscli':
    ensure   => installed,
  }

               
  package { 'git':
    ensure   => installed,
  }

  file {'/etc/motd':
    ensure   => 'present',
    source   => 'puppet:///modules/profile/motd',
  }

}
