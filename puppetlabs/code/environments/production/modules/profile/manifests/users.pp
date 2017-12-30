class profile::users {

  group {'puppet':
    ensure     => 'present',
    gid        => '666',
  }
 
  file { "/home/mzbat": 
    ensure     => "directory", 
    owner      => "mzbat", 
    group      => "puppet", 
    mode       => '750', 
    require    => [ User[mzbat], Group[puppet] ], 
  } 

  user {'mzbat':
    ensure     => 'present',
    home       => '/home/mzbat',
    comment    => 'stabby stabby',
    groups     => [ 'puppet', 'sudo' ],
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '1000',
    managehome => true,
  }

  file { "/home/franklin": 
    ensure     => "directory",
    owner      => "franklin",
    group      => "puppet",
    mode       => '750',
    require    => [ User[franklin], Group[puppet] ],
  }

  user {'franklin':
    ensure     => 'present',
    home       => '/home/franklin',
    comment    => 'the peoples champion',
    groups     => [ 'puppet', 'sudo' ],
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '1001',
    managehome => true,
  }

}
