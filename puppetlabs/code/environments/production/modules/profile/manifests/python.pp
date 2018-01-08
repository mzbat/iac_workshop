# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/developer.pp
class profile::developer {

  # Install Python 3 for RedHat/CentOS
  if $facts['os']['family'] == 'RedHat' { 

    package { 'yum-utils':
      ensure   => 'installed',
      provider => 'yum',
    }

    exec { 'yum groupinstall Development Tools':
      command  => '/usr/bin/yum -y --disableexcludes=all groupinstall "Development Tools"',
      unless   => '/usr/bin/yum grouplist "Development Tools" | /bin/grep "^Installed"',
      timeout  => 300,
    }

    package { 'package':
      provider => 'rpm',
      ensure   => 'installed' ,
      source   => 'https://centos7.iuscommunity.org/ius-release.rpm',
      timeout  => 300,
    }

    package { 'python36u':
      provider => 'yum',
      ensure   => 'installed',
    }

    package { 'python36u-pip':
      provider => 'yum',
      ensure   => 'installed',
    }

    package { 'python36u-devel':
      provider => 'yum',
      ensure   => 'installed',
    }

  }

  # If the data dir creation was successful, set up our projet space. 
  if $facts['data_mnt_present'] == 'yes' {

    $project_dirs = [ '/data1/bin', '/data1/log',
                      '/data1/environment', '/data1/src',
                    ]
  
    file { $project_dirs:
      ensure => 'directory',
      owner  => 'mzbat',
      group  => 'puppet',
      mode   => '0755',
    }

    file { '/data1/bin/python_virtual.sh':
      ensure    => file,
      source    => 'puppet://modules/profile/python_virtual.sh',
      mode      => '0755',
      replace   => 'true', 
      owner     => 'mzbat',
      group     => 'puppet',
    }

  }
  
} 
