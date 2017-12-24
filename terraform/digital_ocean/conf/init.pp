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
