class profile::my_modules {

  module { 'maestrodev-wget':
    ensure   => present,
  }

  module { 'puppetlabs-vcsrepo': 
    ensure   => present,
  }

}
