class profile::common {

  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
  }
}
