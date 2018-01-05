# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/common.pp
class profile::common {

  #package { 'puppet-lint':
  #  ensure   => 'installed',
  #  provider => 'gem',
  #}

  package { 'awscli':
    ensure   => installed,
  }

  # https://keybase.io/docs/the_app/install_linux
               
  package { 'git':
    ensure   => installed,
  }

  file {'/etc/motd':
    ensure   => 'present',
    source   => 'puppet:///modules/profile/motd',
  }

}
