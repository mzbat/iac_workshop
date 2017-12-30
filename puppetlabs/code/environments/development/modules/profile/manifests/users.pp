class profile::users {

  group {'puppet':
    ensure => 'present',
    gid    => '666',
  }
 
  user {'mzbat':
    ensure           => 'present',
    home             => '/home/mzbat',
    comment           => 'stabby stabby',
    groups            => 'puppet',
    password         => '!!',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '1000',
  }

  user {'franklin':
    ensure           => 'present',
    home             => '/home/franklin',
    comment           => 'the peoples champion',
    groups            => 'puppet',
    password         => '!!',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '1001',
  }

}

