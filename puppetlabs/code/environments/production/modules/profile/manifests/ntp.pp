# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/ntp.pp
class profile::ntp {

  package { 'ntp':
    ensure   => installed,
  }

  service { 'ntpd':
    enable   => true,
  }

}
