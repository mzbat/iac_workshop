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

  file { '/home/lnxdork':
    ensure  => 'directory',
    owner   => 'lnxdork',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[lnxdork], Group[puppet] ],
  }

  user { 'lnxdork':
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

  file { '/home/sachin':
    ensure  => 'directory',
    owner   => 'sachin',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[sachin], Group[puppet] ],
  }

  user { 'sachin':
    ensure     => 'present',
    home       => '/home/sachin',
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

  file { '/home/justin':
    ensure  => 'directory',
    owner   => 'justin',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[justin], Group[puppet] ],
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

  file { '/home/kjshomper':
    ensure  => 'directory',
    owner   => 'kjshomper',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[kjshomper], Group[puppet] ],
  }

  user { 'kjshomper':
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
 
  file { '/home/dustin':
    ensure  => 'directory',
    owner   => 'dustin',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[dustin], Group[puppet] ],
  }

  user { 'dustin':
    ensure     => 'present',
    home       => '/home/dustin',
    comment    => 'dustin',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2604',
    managehome => true,
  }

  ssh_authorized_key { 'dustinbixler@Dustins-MacBook-Pro.local':
    user       => 'dustin',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDc4ap1CAZkvF8i9luHW8kakNwHN6HYECSWDtAmshc1BhaomUjeXu3jlq/05+0Azad4y5jG0SVs339XUz1TFDeWeeIooFikAvG3weSpRlC4beQS0gA+L2LNXRLoTXSD1qjwlc5fUBcTJIYhvIm/uSKG4qTuSNlCJEDVsqOpNkbtlqdrvGGw45+dcreDKqLP1IDfkRz7ROCB13mNZC+Feq0j8CVnOtDJUfxC4faDGX+1bmZOeiuz1X88VEAZk29iRv+dAbUoC07KliVErFFFDAAcmTrJXJ5hOnHiYBtNtqWKOZzqoINcIqOa4bEHKBUTWFpw+DNz7C1uB/fSuxUz4UVn',
  } 

  file { '/home/atendam':
    ensure  => 'directory',
    owner   => 'atendam',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[atendam], Group[puppet] ],
  }

  user { 'atendam':
    ensure     => 'present',
    home       => '/home/atendam',
    comment    => 'atendam',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2605',
    managehome => true,
  }

  ssh_authorized_key { 'andrew.tendam@gmail.com':
    user       => 'atendam',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC48PqsOVewfO1FofBxZiLq+7uFtBHDCrgUfogsZNepeBhI/LY66CCpafXBn0/Z1AWByGMStvJ/J126lBb+Jt42pja2z22VGNqPXxe7SB2v7VgMR8p1JskHJV6djMe9rY4H/74iWFyfKI07TYNqz9rOplVS/XKozBW+fL4q1xTeTJYCXgA6iSmMUyOGQVJSNoade2MUnX1enkP0rRAXdbhPUQbrV72AYEudeRY9R0jtbu4B4Wy4cxHm65LUKDoqiEPjFftCM085f+DD2qL3ef5ZklV0nKcvST3nb0MJ2MJbgv+VnludxjsqYUKeruDgu4cQVg8K3W5wribKOzVdPfV/jIkp0RwO+kePiFi1LJm7ZG+/xA5XYyVYzmUxeUDrZ7WRUEQBtpFHhNpoRw4e+tOUDqD4yIx8W3UXok3JEvuCCXNUEfkGHpLex6aR9pVvBpc78m0XYKKrr+es0vu98/7IqrJIFmRn5XEjtolfjGi3ReqYgDTplM0hlJcFEyAPuCHXE/Dd0TY6GTp2/q6OnlTv4JqjK7nQFWm7ZSQHkCdFh3xkNC3GlKmc24oo1qpLLMgA6l5dcjSh8+69d/grygn+tSvcEBVvQV1FToshqdNOELyJaAX7u7YDpPMf0d5ODcMzDirAPGZpmHwlkqG5U2ujLT1pAHOMPxrbC/Uh6ZyAJw==',
  } 

  file { '/home/jimmay':
    ensure  => 'directory',
    owner   => 'jimmay',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[jimmay], Group[puppet] ],
  }

  user { 'jimmay':
    ensure     => 'present',
    home       => '/home/jimmay',
    comment    => 'jimmay',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2606',
    managehome => true,
  }

  ssh_authorized_key { 'jimmay5469@gmail.com':
    user       => 'jimmay',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDyfxnF1evqempYldQHIF3nGqzIYGpdFLt0DhYK1mPcwx9Ppbz6pS/PWzv1jfDPzTv+bBSjujmfYRSijyW6oONRSFPh36ngvRLERxzs7F6TupMiqITBLLZcoApZjNr68YhRXj8HDz4Tu22CewUfLW4877Rzl0ArvJk8DQ1N2ASNbPDeM63eImRasrcI5qAEXF1vcPDlfolgseKARpF+eL2/pQyEJzNm6phj6+nwkfuUYa6OjLxIonyZ2MneG+UFqplZTZdoRo4cvpBn6UwkXBITyQzSrhEnvm//ftLK4zMpWqN+yBn8Vl731UbL6HYPzMojd9nduic0E5DU/is8elipZBxqyRD4kBNbH0YRRgVHdtRywRIbP/7UoBmTM9+BReBbZZLBRDvHjbkCVaXCbcZJuF4cMJFezlMQcXL1JEK8iF8vIts240wPpN3vt1kMa4D9TZbsSJaeYLyUxjc04/4E/hsV7KY3EShc50u8Zhh/Q/xqQW/9mcfQdQ+wlde5o4Hl3CKOMeM0rYQswUKASU0JYsllOQ5qR+qrDk+HfTVwZ+VJSXUiCd2HEHeOURXAO7Munlh9xyl6kMAsQFxEDbncUqmHe4zgpSzqdZUkHpJzMlrkgjMY6W6MmF4nGqjFCxfQQaXDpB2cEsKiJpFdEYc0gWGR8vVR10gb+FgVgx7iDQ==',
  }

  file { '/home/ascherm97':
    ensure  => 'directory',
    owner   => 'ascherm97',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[ascherm97], Group[puppet] ],
  }

  user { 'ascherm97':
    ensure     => 'present',
    home       => '/home/ascherm97',
    comment    => 'ascherm97',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2607',
    managehome => true,
  }

  ssh_authorized_key { 'ascherm97@gmail.com':
    user       => 'ascherm97',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDbwC1LB++qzjq6Qsd5UOl9O3puz3gp0kABviPtZaLJjs84Zz7/GN1xkQM6rkKeatfGBW8cXBYr2fmZEtneof22HO5SwKnurVQeDna2Mjc3xjsz+1lcl83OkAVq36YKPZ6kF7Dy5HXpEIddw+YQT3DEJSoTARk2I2zNC4d4rPjvWBYteDHso98qzS0qltK+mIfmai/CUUN55eLfCQ5yOzSqW36lQwP72ZQH65DXTJyMiJaLM/vInZ6VJDbcBW0UNSQWA3Uv+4akobPU/54jZGPFJTXDXoidlRnOWPR5wel364AKw+mMLBYDkOAkI8Lj9zJ7ED49HN3GHxMWANL+aY4RLaO26eJNuqEbyJ1zu/aZhmXeDz9p+pRTSYgDvCRXlyVj6E7P/MiJ8HzveIFQdGP/fOJ0ojiZaluQtAy+WDX2STgXad3LTJDQxIah9+JBFXYEgKYbeieAhHIOC6uMX9BWeQW8E2LOl7Hmg0OL3eXCdQtysUGbQ4cAtEvUXCjgoUbAZJQ9AvOrnXAsRz4r5zdPk1SZckPkquDi0fF3zUSqyeNxQ7MaxSlQCom923pbCn+DQU/ODsGhdohrz5DLt6pQIzRfsgHIUywj1JbDD30lkQEY55r3xQZR88GlFjn+s2b5sC6KZTkOp3yOQC4zglBcsNDEgngmXhULY7YRtDt3Aw==',
  }

  file { '/home/apasternack':
    ensure  => 'directory',
    owner   => 'apasternack',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[apasternack], Group[puppet] ],
  }

  user { 'apasternack':
    ensure     => 'present',
    home       => '/home/apasternack',
    comment    => 'apasternack',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2608',
    managehome => true,
  }

  ssh_authorized_key { 'adam.pasternack@gmail.com':
    user       => 'apasternack',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDcB1fvWAQdhka3l1e3XSYZCIv9BLPMQbu+wwC+g/ssMh2K4VeVQk4exaXsYYJfGR0tfzc/fqZLAIfxhQlVP90xVE5skUZj0HYoKnKyJMa8QJ4wnuk5UqZe8RKmGmJOoDE7YqClxlQf9TQHFps232Qhcz9jvnIrZ4ESj2EponZeUENglcjNBDeYZXVhHB00SPICDOuTac9Z+5kfTcVlhhBCnai/uPopdOlxWh6KpLOqpG53oTnWq9Cj4PMVMfK6Dq/z0MizfKpKvvpeHGvorYuAXCp3ke+wqGtVCzBX8SB5bnLxSwrmeUIDRJmdjhmZuY47/CJw4UNjYY20+LwqOE+9f/4v26EQmG4DBaxfHvOVVYYeHCix9LKXUy/Poo6933aHYwGRtu54aNUlhc0sNq9k2HhwSlQgvvcTib9/U3o6K/cKHHKQyRDNGYtmkeOY6/mZWmlWLIypPwZzsIAz/F+fMkhis3CytMooIZaMh615ltlKyy5ooJSQ2TgQwFTSw6FJqBN2FeAnn9+AIv7HNnCXwm7jC3i4um0iCdPw5T2KJI1jyfFWVj2L0YpF+wxxRrJRQ1bC7a8/nekjBtbA3L8oTLtDOy9DAx55AL23URz068i/JEO0t/lb+I5eeHmGpZaAMPY/LnNK8cYBQXjFqmowmuiwsOdt9IgzyaiWKkI5QQ==',
  }

  # This comes from ../lib/facter/homedirs.rb
  $facts['homedirs'].each |$homedir| {
    file { "/home/${homedir}/.bashrc":
      ensure  => file,
      source  => "puppet://modules/profile/bashrc",
      mode    => '0644',
      replace => true,
      owner   => $homedir,
    }
    file { "/home/${homedir}/.bash_profile":
      ensure  => file,
      source  => "puppet://modules/profile/bash_profile",
      mode    => '0644',
      replace => true,
      owner   => $homedir,
    }
  }
}
