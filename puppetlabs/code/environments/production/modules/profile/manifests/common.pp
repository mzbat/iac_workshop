class profile::common {

  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
  }

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

  class { '::ssh::server':
    options => {
      'PermitRootLogin'          => 'yes',
      'Protocol'                 => '2',
      'SyslogFacility'           => 'AUTHPRIV',
      'PasswordAuthentication'   => 'yes',
      'GSSAPIAuthentication'     => 'yes',
      'GSSAPICleanupCredentials' => 'yes',
      'AcceptEnv'                => 'LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL LANGUAGE XMODIFIERS',
      'Subsystem'                => '      sftp    /usr/libexec/openssh/sftp-server',
      'Banner'                   => '/etc/issue.net',
      'RhostsRSAAuthentication'  => 'yes',
      'HostbasedAuthentication'  => 'yes',
    },
  }
  
    class { '::ssh::client':
    options => {
      'Host *' => {
        'SendEnv'                   => 'LANG LC_*',
        'HashKnownHosts'            => 'yes',
        'GSSAPIAuthentication'      => 'yes',
        'GSSAPIDelegateCredentials' => 'no',
        'HostbasedAuthentication'   => 'yes',
        'EnableSSHKeysign'          => 'yes',
      },
    },
  }
}
