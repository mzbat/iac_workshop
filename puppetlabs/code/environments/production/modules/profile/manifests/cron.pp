# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/cron.pp
class profile::cron {

  cron { 'update_puupt':
    ensure  => 'present',
    command => '/opt/puppetlabs/bin/puppet agent -t',
    user => 'root', 
    # every hour
    hour => '*/1', 
  }

}
