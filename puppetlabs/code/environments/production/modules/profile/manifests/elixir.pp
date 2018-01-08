class profile::elixir {

  # http://www.jeramysingleton.com/install-erlang-and-elixir-on-centos-7-minimal/
  
  package { 'epel-release:
    provider => yum,
ensure => installed,                                    
}

	Package { ensure => 'installed' } 

  $dev_goodies = [ 'gcc', 'gcc-c++', 'glibc-devel', 'make ncurses-devel', 'openssl-devel', 'autoconf', 'java-1.8.0-openjdk-devel' ] 

  package { $dev_goodies: } 

  package { 'wxBase.x86_64':
    provider => yum,
ensure => installed,
}

  package { 'wget':
    provider => yum,
ensure => installed,
}

include wget

wget::fetch { "download the erlangs":
  source             => 'http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm',
  destination        => '/tmp/erlang-solutions-1.0-1.noarch.rpm',
  timeout            => 300,
  verbose            => true,
  nocheckcertificate => true,
}

#sudo rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
package { 'esl-erlang':
    provider => 'rpm' ,
    ensure => 'installed' ,
    source => '/tmp/erlang-solutions-1.0-1.noarch.rpm'
}

 package { 'esl-erlang':
    provider => yum,
ensure => installed,
}

  file { "/opt/elixir":
    ensure     => 'directory',
    owner      => 'root',
    group      => 'puppet',
    mode       => '770',
  }


#git clone https://github.com/elixir-lang/elixir.git /opt/elixir
vcsrepo { '/opt/elixir':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/mzbat/iac_workshop.git',
}

  exec { "make clean test":
    cwd     => "/opt/elixir",
    alias   => "make clean test",
    creates => '/opt/elixir/bin/elixir'
  }
 
  file { "/tmp/ayy.exs":
    ensure   => 'present',
    source   => 'puppet:///modules/profile/ayy.exs',
  }  
}
