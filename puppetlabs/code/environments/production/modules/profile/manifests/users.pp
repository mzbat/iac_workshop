# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/users.pp
class profile::users {

  if $facts['os']['family'] == 'RedHat' { 
    # do something RHEL specific
    $groups = [ 'puppet', 'users', 'wheel' ]
  }
  if $facts['os']['family'] == 'Debian' { 
    # do something Debian specific 
    $groups = [ 'puppet', 'users', 'sudo' ]
  }

  group {'puppet':
    ensure     => 'present',
    gid        => '666',
  }
 
  file { '/home/mzbat': 
    ensure     => 'directory', 
    owner      => 'mzbat', 
    group      => 'puppet', 
    mode       => '750', 
    require    => [ User[mzbat], Group[puppet] ], 
  } 

  user {'mzbat':
    ensure     => 'present',
    home       => '/home/mzbat',
    comment    => 'stabby stabby',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '1337',
    managehome => true,
  }

  ssh_authorized_key { 'mzbat@protonmail.ch':
    user        => 'mzbat',
    type        => 'ssh-rsa',
    key         => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCnAlmn1fWBhCiGW0Y5chABmZz1QrajI9T+QOq4Zprj0MDs3fHiwkMYS52pz090RiO7LpvHWoruYOvwh9NQXUboLASgR0XbM5lbxvWN0n4ACGtVuFGpe5M1bapxXk517d+Dixqv7cvUERPa5qH8bbSBtN4yvRHYf32fppeBRgkVuKMIEal5ODT6qlOmqx8dMCuDmb30hbS+MMAGmHTUTTLpzyGWkUVs6bhu79NM7QiZ2cN0mWXx7vM7eAGHcffikIRdAofpkCKzu7xNpAF7JxAR30lQh0HTCTCXG/IFBD5LnqymbRCWUKulGWdMUgul/lFfrZ4zU9MKqyzq3Q3wYa7bh0tgAEPRAJxtoszNg9QMFdM7NxAx/FBA1AV4SVmawICYZZSOC0LD7efOV3liHxcPtDaxDIAmxfaZzPGknkNWgobrhZ12xKufj4o2r520+IMJJiKVmF8Br715/dUGzYjvs4/XQRO3OLrKbbQkwj7B0mYDKm78m+NNbabw8z0oUjMW3BTgP5SENDgCMH3fqYp7SJVnpTZWcUyQeRGC1YEILurgJwyFcrwk5eLl+JhyGCkJ0N5b8diIuL0Ze/uoSW6WjfVCpQg/YZFn+hKtC1AELsPSAvbJIR5Bm8VULrsfieUT3GnObx2CjYp83RQdA0K6KEJOMc8NUZtxA66W4rrJHw==',
  }

  file { "/home/franklin":
    ensure     => 'directory',
    owner      => 'franklin',
    group      => 'puppet',
    mode       => '750',
    require    => [ User[franklin], Group[puppet] ],
  }


  user {'franklin':
    ensure     => 'present',
    home       => '/home/franklin',
    comment    => 'the peoples champion',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '31337',
    managehome => true,
  }

  ssh_authorized_key { 'franklin@lanparty':
    user       => 'franklin',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDFYLHT6U8bzkM/OSYeHccQ8MvQDBAnq28wYHCLYmOUKxKO0CxPHW9h5A50ry/ETyAHRNVDs4RsHjmFzTjOnT1nzPZQxU0hhGEGhVCx8VcBWolci0AL3MI3+qsleb1iNwEFzDmQ1qImkHmG7YKB9LDTSZ7a5eVZV5Quvqya0TSIiahGhiGCU++Xs/kC8F4eK45EypvNF5z827oMWkzrUtDtLVCFZPl5cgbW7OP1fxhN+61ue2XZAqQOyy2rfr/5V8GABcNP//be4AO+++NBvvXKlaAhn6vJ9HSuQT0aWA4PWBo5Vv7PSxUBWfRbTfOw1QspR+wPOM1Oq4bAjnIygqgd',
  }

  # This comes from ../lib/facter/homedirs.rb
  $facts['homedirs'].each |$homedir| {
    file { "/home/$homedir/.bashrc":
      ensure    => file,
      source    => 'puppet://modules/profile/bashrc',
      mode      => '0644',
      replace   => 'true',
      owner     => $homedir,
    }
    file { "/home/$homedir/.bash_profile":
      ensure    => file,
      source    => 'puppet://modules/profile/bash_profile',
      mode      => '0644',
      replace   => 'true', 
      owner     => $homedir,
    }
  }
}
