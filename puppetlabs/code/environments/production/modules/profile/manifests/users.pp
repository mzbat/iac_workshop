# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/manifests/users.pp
class profile::users {

  if $facts['os']['family'] == 'RedHat' {
    # do something RHEL specific
    $admin_groups = [ 'puppet', 'users', 'wheel' ]
    $groups       = [ 'puppet', 'users' ]
  }
  if $facts['os']['family'] == 'Debian' {
    # do something Debian specific 
    $admin_groups = [ 'puppet', 'users', 'sudo' ]
    $groups       = [ 'puppet', 'users' ]
  }

  group {'puppet':
    ensure => 'present',
    gid    => '666',
  }

  file { '/home/mzbat':
    ensure  => 'directory',
    owner   => 'mzbat',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[mzbat], Group[puppet] ],
  }

  user {'mzbat':
    ensure     => 'present',
    home       => '/home/mzbat',
    comment    => 'stabby stabby',
    groups     => notice( $admin_groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '1337',
    managehome => true,
  }

  ssh_authorized_key { 'mzbat@protonmail.ch':
    user => 'mzbat',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCnAlmn1fWBhCiGW0Y5chABmZz1QrajI9T+QOq4Zprj0MDs3fHiwkMYS52pz090RiO7LpvHWoruYOvwh9NQXUboLASgR0XbM5lbxvWN0n4ACGtVuFGpe5M1bapxXk517d+Dixqv7cvUERPa5qH8bbSBtN4yvRHYf32fppeBRgkVuKMIEal5ODT6qlOmqx8dMCuDmb30hbS+MMAGmHTUTTLpzyGWkUVs6bhu79NM7QiZ2cN0mWXx7vM7eAGHcffikIRdAofpkCKzu7xNpAF7JxAR30lQh0HTCTCXG/IFBD5LnqymbRCWUKulGWdMUgul/lFfrZ4zU9MKqyzq3Q3wYa7bh0tgAEPRAJxtoszNg9QMFdM7NxAx/FBA1AV4SVmawICYZZSOC0LD7efOV3liHxcPtDaxDIAmxfaZzPGknkNWgobrhZ12xKufj4o2r520+IMJJiKVmF8Br715/dUGzYjvs4/XQRO3OLrKbbQkwj7B0mYDKm78m+NNbabw8z0oUjMW3BTgP5SENDgCMH3fqYp7SJVnpTZWcUyQeRGC1YEILurgJwyFcrwk5eLl+JhyGCkJ0N5b8diIuL0Ze/uoSW6WjfVCpQg/YZFn+hKtC1AELsPSAvbJIR5Bm8VULrsfieUT3GnObx2CjYp83RQdA0K6KEJOMc8NUZtxA66W4rrJHw==',
  }

  file { '/home/franklin':
    ensure  => 'directory',
    owner   => 'franklin',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[franklin], Group[puppet] ],
  }


  user {'franklin':
    ensure     => 'present',
    home       => '/home/franklin',
    comment    => 'the peoples champion',
    groups     => notice( $admin_groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '31337',
    managehome => true,
  }

  ssh_authorized_key { 'franklin@lanparty':
    user => 'franklin',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDFYLHT6U8bzkM/OSYeHccQ8MvQDBAnq28wYHCLYmOUKxKO0CxPHW9h5A50ry/ETyAHRNVDs4RsHjmFzTjOnT1nzPZQxU0hhGEGhVCx8VcBWolci0AL3MI3+qsleb1iNwEFzDmQ1qImkHmG7YKB9LDTSZ7a5eVZV5Quvqya0TSIiahGhiGCU++Xs/kC8F4eK45EypvNF5z827oMWkzrUtDtLVCFZPl5cgbW7OP1fxhN+61ue2XZAqQOyy2rfr/5V8GABcNP//be4AO+++NBvvXKlaAhn6vJ9HSuQT0aWA4PWBo5Vv7PSxUBWfRbTfOw1QspR+wPOM1Oq4bAjnIygqgd',
  }

  user {'lnxdork':
    ensure     => 'present',
    home       => '/home/lnxdork',
    comment    => 'lnxdork',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2600',
    managehome => true,
  }

  ssh_authorized_key { 'lnxdork@sager.rubber.horse':
    user => 'lnxdork',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC4pIXmMB2oLJYbj3khLeTMFmKnB56u8xUydZUqjuyjuQMrWDhsrV0mTlz9RKLFD0TJXGsh2BlFgcLP3+sRkL34Slyknpy2R+xxr5q7P8wggmi9XK2wFpJptRiYCVdaTLdrYNPuD4U5inrMGiYPop4mO4uUCTbsUB8Re8eBe8Agx6keUTQbl8a2Azyfd9qzQBk8BrtskvJBMQDWccDrcKdqH/0AKTUrQpdi+eGBvOwbsljtXGRDYsjwgKkHA4PKx8MpGBNZHg+Xlf8El5GKP0GYiRBGu35Ag7PqQcfQtPULYlQjqA3/VScLfQgt5a6AeUQs5w3H1g2a3wqwkEKWBDcz',
  }

  user {'sachin':
    ensure  => 'present',
    home    => '/home/sachin
    comment    => 'sachin',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2601',
    managehome => true,
  }

  ssh_authorized_key { 'sachin2636@gmail.com':
    user       => 'sachin',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDOSTdpjS2njnqAwfDWR68J1O33K0X6Sg5cnvMW0SceDGNF3BZSUHPWT10dk4RHGDHjLB9IoLbBBeCx1xJGVpcttiYa7xsya5wjW3e0ZXM3xejpT2SYsMn+KBOkJY7x4y8A9DlxqEtWuLlVV0e95dr5Kzz0vQlrGb4En4rvQ7+Q535m6EwRnoU0KZfvd36/a6NttS+RxvRPnZZ1/kTzHeGO0tLlH/mU4ZwMLFcDyfOOSRhdgRVWrepRGp8DhLwt+lO2FpeTTju/EPsMfdKO2iTVjL9aSDtUwlKNxH0MHA/YuUP2mvL72jZTeG0qg/Y8PTwdE1OC/Pb6kq1dNc0RxCTpcOIgTCIYvLZ3eqx03sLb2D9eFBpVt3UmPhy6Lx54oxpn89VHQHfu4Iw37MNP+oPm6OGNT/JDJlA71Ekv5gH5Qf5/eE2BhQdZPNr/IfAr4HopPMTxe3oqyfGKZ8vpe19QwE/7U0/qtlmAVxZCLPg7dUQEqVDjF4mMHLyPh8Yvf33t5/QNTHV01Wk0sgl5YLWxht8+5n7EbL69VrH5RDqO3me6PjEWidD2MK5WSL4R9tP0fej62gdg0c8LDAHydYUDvjixy+bynHJCQ7QHG29SX2v8UJYouCJmQJSuvUqH+C2V5N9QCOb2smRq9yaQ8IETjP3a0QaTZcPgipIFFQJvnw==', 
  }

  user { 'justin':
    ensure     => 'present',
    home       => '/home/justin',
    comment    => 'justin',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2602',
    managehome => true,
  }

  ssh_authorized_key { 'Justin@Justins-MacBook-Pro-2.local':
    user       => 'justin',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDerEhtIFmkMSii4Cq7bjf2b2I9jtRXP0w3tN9I9k1wKhWpsY3XdojvkBiSilartY8BdL4x8XOEeSqHpmgX6p8OMsWwxbXQ51ZFm3VfPsZe3RsDvcUKBJcHxnk0fqXAcYHXyIEys5XkYPhwitYAru2L/Rwr2IkKQW8VXx1tQ9v47NxEUAy6+up9V8Z7oofuws4meWdjL+iQGnCDqhrqjdMPyTppI2wTxWO+QqpaY/UxLoJuvEA0mQf3AJAiCZDVcxqPUfoGH+lbnFwsSQJi/0KFLevBRwGI1DrYQVhOP36Esr2TI60l0h36lDe0HIPMbMafbwNJsuhNre5BL0IcXI9P',
  }

  user { 'kjshomper',
    ensure     => 'present',
    home       => '/home/kjshomper',
    comment    => 'kjshomper',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2603',
    managehome => true,
  }

  ssh_authorized_key { 'kjshomper@gmail.com':
    user       => 'kjshomper',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCtLnDZ5aR62LtoBl/CcUbFc8ZafNzox1gdbpQdlEGFLyghF8mj2RrmieQXT4uZSIo4V79ETp1VEsF6VIXmc2rnD4jeZ7o8UtCMD8Nxauu0dCy8xNcuce4+HmszECbdw26Hx8sjKpRJwTWcCWXfUidSDaegKgpQ+IGGKotv6W4KG7t2hesLeL8iPr6Pdzxbp5KZjcrWsg+WttXHU2+RTJzk+RUo1pcaIXiq1DbNHsMlskt4ZwFHNhVymQ/tmcadDEDtNPTvgGojUfStHyRLRRqgMPWfz5sCXHRn4q+rWOThM6SqA0x1WL/sfwd4nMFmkuZzys+2w/Igdcqa2NevdTtRaKyIX6EFXwnuTPnzwOBvYKzy3tLDQF2J97e1rX9yRd+tlnIp5XjartHexXxcEt90Vru07OkGBLVUTJY2BDKwomdvo/+sPuRyA+xlHAsV6vhRrGXT0biM2rgyypZfbxrol7PL2vEBvxc273aEuX7tpO3wea7JTbCz1mt9ZBbuc2OW5l+kwxKkrVR2BlXLL4LG4jl2yUd2hMH9MyTRCpfjms5Hexa1EbrJMqZ+0pzNjvuleZQLsel8xNMUu/eKdaAl+kGg6yXHUwbRzDDpTx/37mNnHibBBP3vbd+BItE4RAoHo3bBrrzTsk6hFRx8yT9TIQOB46kIstXEapkoYbavCQ==',
  }
 
  # This comes from ../lib/facter/homedirs.rb
  $facts['homedirs'].each |$homedir| {
    file { "/home/$homedir/.bashrc":
      ensure  => file,
      source  => ''puppet':#modules/profile/bashrc',
      mode    => '0644',
      replace => true,
      owner   => $::homedir,
    }
    file { "/home/${::homedir}/.bash_profile":
      ensure  => file,
      source  => 'puppet://modules/modules/profile/bash_profile',
      mode    => '0644',
      replace => true,
      owner   => $::homedir,
    }
  }
}
