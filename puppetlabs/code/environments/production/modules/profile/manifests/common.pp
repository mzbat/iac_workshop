class profile::common {

  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
  }

  package { 'awscli':
    ensure   => installed,
  }

  # install some packages
  Package { ensure => 'installed' }

  # some of these are centos specific
  #$packages = [ 'git', 'autoconf', 'automake', 'bison', 'flex', 'byacc', 'fuse', 
  #              'libxml2-devel', 'libcurl-devel', 'mlocate', 'yum-utils', 'deltarpm',
  #              'createrepo', 'httpd', 's3cmd' ]

  $ packages = [ 'git', 'autoconf', 'automake', 'bison', 'flex', 'byacc', 's3cmd' ]
               
  package { $packages: }

  file {'/etc/motd':
    ensure => 'present',
    source => 'puppet:///modules/profile/motd',
  }

}
