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

  file { '/home/bradknowles':
    ensure  => 'directory',
    owner   => 'bradknowles',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[bradknowles], Group[puppet] ],
  }

  user { 'bradknowles':
    ensure     => 'present',
    home       => '/home/bradknowles',
    comment    => 'bradknowles',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2608',
    managehome => true,
  }

  ssh_authorized_key { 'bradknowles':
    user       => 'bradknowles',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC8DUZLtThaQhBtsTYBnJMQPM94RRNZ3xqqd5LIyCXQt66YHcWGSP0RSevd0oh9ibsgSbrtR+GWs918Oz+pdX0DzzGmHpHV3tcNyD9Vjo/tgEMR1GLgAlln1xKHVy/rOXqqS7e/IoR2+9Z31bjnJJglhIEjC8M7ysa+s5TXEDiUVwAv8Kgus0ovqwkFtfJVe/H1blWPhcjUoe8VAKZDNzpU9LkU34uWmY6kM5ID/UE7G9KMYwSYrv+feCDK8lcoViPkurH+mq6X3xPNCXhgYTZ3EvrAHBLTZ/Wxd/79apfjU9w37mBhDd1C/98CvU6ZkRwe1VcwveIMOu1sAIJiv/aPaSnLXJ+OAOhLfpC//rwhXCbioCxMmZJUguck/9MX2pdewyhfFebIsb285aezfpZFMrZMqWXyeZFgelFujuma7BXP025hsOA3BgHYyKY+ID3b9f5l0im7VyvL7pPmQpHWR5fIcDPHlYc7cHoxrjpL3ZWSGOsSre4UlN4RZ9+0X9KE8qnOJ4CVFgmi3LQqcynqykbtG0VfK3Q2xaK8VHssDG0JvdXBlZF839hKmVIPWlwEVUieGodQ7ZvtnSe9ybVbpcZb09IMm5OQoGkdhiOAtIi5RwB387ahGPSSUApKjf4ccRdqANyKxb9V6/DiAQA6K3erkIGvsPx5X8fnXearSQ==',
  }

  file { '/home/jameskbride':
    ensure  => 'directory',
    owner   => 'jameskbride',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[jameskbride], Group[puppet] ],
  }

  user { 'jameskbride':
    ensure     => 'present',
    home       => '/home/jameskbride',
    comment    => 'jameskbride',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2609',
    managehome => true,
  }

  ssh_authorized_key { 'jameskbride@valhalla.local':
    user       => 'jameskbride',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC7zL7rt0c4gdWE406j1e+NG1yYBHnyAtEIK86O0RUpOY9w744WM7/uf6qtN+dO/J+fYSINbpAxb8B2D9tciyBCGXmeLNCCD34ItEmvHhZV+18i+iyhkD8IXCutF/fhM9vyKMlMQ+ROieukGUTbvDMXzTRaOz1aImH5P7r3jCkOWiFVpunT/IF/OZvZQTHNjVYiyFnsBffMLNDc8B1lwdRiaR7RW+e5mRGnuYVcC9FExwbKEOik2ZENhqX8uSVmMNlnRxkgt57T/tGCfP+38SGke4zYKw6EQ/DpRJaZmAOKQduid3FZUBmV5q0UOWVx4skl6nC1qGR8aahq4vAnNCjj',
  }

  file { '/home/tvonmoll':
    ensure  => 'directory',
    owner   => 'tvonmoll',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[tvonmoll], Group[puppet] ],
  }

  user { 'tvonmoll':
    ensure     => 'present',
    home       => '/home/tvonmoll',
    comment    => 'tvonmoll',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2610',
    managehome => true,
  }

  ssh_authorized_key { 'tvonmoll@gmail.com':
    user       => 'tvonmoll',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDyYWjb7ddXPZdwttCWj4KRiQQB3dvoxSGWxLPGa3mb46H+8Foam+gAuMNVpo6zNSbmWIMhiVpT2pKz+e3aADQCi64duNjdk+/XOvBIvyt+2m1D520dmP1OZSgtO1DEAcQbUYdJh/7UZZE78uBEkiyyWzbECQUFP2R0B3qR6XN8Air91BmO3ahuDk3OA92W6nARrcnmRJocmfXvRXnYUfHOsfUqsH9XRJ2Ou/fk5Qffq6xpoFwWTIFCQ+2PJcQEE1w00HRqe6MC3uX3U/Xbv3m+lUKfGaXWtYFFfXUmWYYP3MuWnbDEf0WxLiC7tB08XXCADQ9cz/Ypo0lcDl/MYAL041iS9U/rFfy34W6Y7K5AQEEPB995iqj/+y6kjfcyuyK0TU9AX/pww1zKzBq7UzGH7fvDdNkgtbi4OQ18eEl2gh7nNjGcHTmcIXn3zZKVYSyVBwTT6aFLW/lCWbjpvmax4BP6b2G3jQEgMYPkDBprCIuZ5gC+ILKAcozcWllmbQTOnudGSp72YDtR9Jkc1Rg9YjLLWlMmonqIsAoa8p/0sJIxayQxLn4iZWYSsDWBcK/t39uAG60NmpfXukbGsotuUI3SCd14FVJ1p0AMlNmW0ibiF4GVlgkpz5QE7NLjGOa5Cq4vV+1uGkW+Mt7Qq+Wm9XiCnjxnvOLiXTANV5eI4w== ',
  }

  file { '/home/tzm293':
    ensure  => 'directory',
    owner   => 'tzm293',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[tzm293], Group[puppet] ],
  }

  user { 'tzm293':
    ensure     => 'present',
    home       => '/home/tzm293',
    comment    => 'tzm293',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2611',
    managehome => true,
  }

  ssh_authorized_key { 'tzm293@msn.com':
    user       => 'tzm293',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCbhsWdhZFnKD7a9oJyZD4W6vSmcV+7i+/dQfBuNPVjVAaeYHrcuD2d9XWuwymCRwSD8ccERCbIjoe0M31xDZbtiNpDnmnSIo21TS9X1kMQWcm2I6s2r9mQ/XXMoSScysFmH6UZFMrIf/rFZNBz9+0mc293XHJBkUlbc00t6WURCDN8m+34BH4+H/TCbKhZ2FL4VU6ZGNmobAK5oHozYiBLgX4RYRNqQx41XceE0kMw7p7FD1Iay8s5F2gY8qCzhD6Nahzuk2DB2ZRDAHV78o0tcHqrSzqpZZ7f/M2mD2GRoB+9IAMITGgoPg98bPA+4R1MSVEWnLUbD+Ilx8lcDVoeNJDAFnoi7IN0e6WVev9NEah/M95rs+rCoPPQENuzCuqP0gyXu9l+UAknJihTK0tI9ZnioJqdbGSZXQxR312zFUUXenDmj35B43+Z3wNhLeB/gnHHjtsL8FFhR/LTEgwaXICfJHPrfixNkWn+XD71YjaYY6H8Ei1VIKUPEAZEBihN/1h+UONPVBYdYK3z44wAps2weKWEJ2LLiDIrfCtmj5v64Au+JOtzSeFVAJDSgfVjJJIOB5t7CD3958/Pr0DUOjXI+LqsaJ1L14RC0jn0hZ8fbHBSbUQ6zqoXy6SdUZ0wULMVnB4lTjfpa/GhDhRRxJz4RYuh0Tz8nD/Kr929uQ==', 
  }

  file { '/home/mgrecar':
    ensure  => 'directory',
    owner   => 'mgrecar',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[mgrecar], Group[puppet] ],
  }

  user { 'mgrecar':
    ensure     => 'present',
    home       => '/home/mgrecar',
    comment    => 'mgrecar',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2612',
    managehome => true,
  }

  ssh_authorized_key { 'mgrecar@gmail.com':
    user       => 'mgrecar',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC9oj1FReGWE9WKHVzaY4bSmQ6zSVBWkcBk0o612t42uSYXPWsjnx5Y4ewpa+KKNe2WzfVKY3XosRRM6zyZKy9huPqDpqdNuPOD3kbFTpmOHEpsqB4edmG4jrUp8Q6k2VyD1Xn7tbSdwKt4wSmpx1vSNHYViYuUospPoWkJW8J1MC4Thppm3jVnwg1Em4EiSI+0Mkdl1/vdRuVVBFLaK8SqYRnLU+wdY+sxGYSZep9N8Tfvdj17a7Sh0RLFFEYFzj7RwsS8gnJvQFO37lICKWbTdM5U+maB9vynJbywZaXpZUr71RYVuzE8VeXNmRdlpzT+aLzVVRovFSbwlloUtGsr1GkDI87MeGn7/7ikC0k6aBZKz21ZyRkLKAwD/bJNUZhSG99f+RQ83TSJv+QmPz/omkifTG6wxgHaniAOwNpzNHYI19C4Yex7Fzg7boPi8ac59pqWnlt14BWdMDR5C5n7ElEg1M2p2KKWK5IdE7eiMSCCInBNCaCkaWQQQ7dD9Jsl0RzUgbY4I4rF9GV5RpXm3/adb7PsRESRihWvSnfjqEflUM663h6iP9oGCKSxZhqCxzHm2Eggkpel4DzVWBFQa2/iJ7f2zyF9Si+zsxMrTCTcHWeDQtEuNJjsyhqW15tLoEz1qfFVnzDmSlGHd+WlLb3l3s+lKUEtpMVy3dPsXw==',
  }

  file { '/home/yamikuronue':
    ensure  => 'directory',
    owner   => 'yamikuronue',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[yamikuronue], Group[puppet] ],
  }

  user { 'yamikuronue':
    ensure     => 'present',
    home       => '/home/yamikuronue',
    comment    => 'yamikuronue',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2613',
    managehome => true,
  }

  ssh_authorized_key { 'yamikuronue@gmail.com':
    user       => 'yamikuronue',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDLNIBUZ1VmJmM8gGDYXQn+WG9A0kURajhLMsCpqEgUiv5x9+ESD+VoUVRyz+zxxazLQ+5IakjfgxrcFn9COZrYl3zEvyTqd+jOB/09easzln+4n+o1J3kNDkvz+RFDSHXlMqR5DOb4w0n+E4IrXFiQFlHDksBrw/mQHsAmq0HgfanMQ24IktUmdk7E2jLJW02nbS//BYR2B5N+SU6XN0Ylc4DeRanbUajAWi/+W2gGbOlCiTgt5tZdQdPypnKsbHAmk+aCSeyUcK0K19yISx+LXivLKe6WtTAl6SlNKgLeUZ3woOfr6RQQFgoAd+3erIFvO4xnljZqPSleIs3LCjGsi2rSxH/EzMBawYd0CNhVi3CncNsT1pKDaZ6yIQXvkV/OT53IYbHE6LgsJXrxDd91AabQq2hlDUsju8m6Hhus+sV/cPlGUZIHycIHgMRheSUQCpZvo0E8ShshhhM6dIxIdfnuxgU3pLy0tti1LESDOoUl5AFPH4tSNlc4IAfwVsmWsl6FTwRtN2ZP4bt3ZormxZGJf6Tkf2i28m3MVQg4DExiaSPPi7tmuIN6GGco2yznvnPWvd1XFqV6K3sbHwOsr+QEUukYNrN1syRjQOUj2/Ivli17SUVRjip4xpgljYq6km7E6T1US4ZyjWJwFbdQOYgQSUAoVvQvZTkUZQ+LXw==',
  }

  file { '/home/danmit88':
    ensure  => 'directory',
    owner   => 'danmit88',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[danmit88], Group[puppet] ],
  }

  user { 'danmit88':
    ensure     => 'present',
    home       => '/home/danmit88',
    comment    => 'danmit88',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2614',
    managehome => true,
  }

  ssh_authorized_key { 'dnlm88@sbcglobal.net':
    user       => 'danmit88',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDkysyED2Wap09saNQp32BH2hMlwLy4oU8Xccw/ZKw3ncUQ8GesnYD3Y+GfuGygcd+UxdXhQn/U0Hm1+1pSa0fl/0G5bOZ+Wpwg46vlU9WJtlohMLPui0Zfb0TCSBO86BE9mD3V3GLqZx0m7eculA91/yi7m8k2/mRqwqQ5VC64AjTJXQx4PlHsRF3Xg3wcGdQCCA041ep3QmN3JcGSAllwLOGSJQKQCusGhwsrXvpi15StpFsXTJhyA+A1yfJ/z0yMOgtwWBRLldoGzEpwlzR3BalBebs3xtCzSa6ruL1p7ZF3Sj9r8vnGEz2ujA05T4SO7orkerzH0KpaU/OXWGTj1ys3OicvsmyZsvDGWRi52J7PBcIL5xA4OI9ts78Tg0bdzaMjgJytguxLxN3BLTNIX5eKo/fRwaEWT+wknU0yR3UDdfia/pvbYIeiOLoy3X77NCT/Liy4wuoKir6WHvdKcu1UxJRuZanOBypgaV4qDafyrLd/NrhpFLpELirkun6wm3C+CQyV7g/vGprmXww+hpVGsViWl5SI7zhSpkWwAUQnyvdq7CcgbB44j+zvjOVlcuvfi+/HwNJ4YueJYv1pWY4/WbauF24kjyWz0V9FQliKdd3xW6+MW6uctQ2mKvibLIGlApYUk3QRQABtn7LI4rdAb41PL4W9DVE9Psi7cQ=', 
  }

  file { '/home/alan':
    ensure  => 'directory',
    owner   => 'alan',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[alan], Group[puppet] ],
  }

  user { 'alan':
    ensure     => 'present',
    home       => '/home/alan',
    comment    => '8',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2615',
    managehome => true,
  }

  ssh_authorized_key { 'alan@bondbunch.com':
    user       => 'alan',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDbVRwJSPJGyvQSCM5nRl7XtkoIWHJtPeOhckmtnnp6sfdnnG0nEeEEdaK9Ho6ggT0Elr7yG3Aawn4BjFxYPxebjSXYDwvDGSjbofd/umGq1Kgx9qnbGv8hvoe8C22bGVftAKBw94ZljQL2siZnDulwBfDKChPIiZ26r/Whaemzm5/7Mz1BvVVuBPaahK2Dt/6RjmfbuIIwHVTxMN0Bl/xvDX8p+GoVJD1PuKmaWX3WfDDc896K81f6AxwxoVaraLePjNpKDf3O6vkQs52ZWESFNkXWguZ3NIYmxFIwNeVVGNswwu77vN4M/PVl+WsefrkiL0AKLSZB992JMwok2tAyTxANh22TCnPPetIC0uSq+v+W9pYNls5+HByzfUxhZVUJv0D28bhk5fZIag8NnBpi5FiIGy1LN7f95Ep6uePvoTk4QnGaR4z8p7khoaIQkPWLswdMljIPsxclR2iiHZ4ftqjb2cX2ZLgL68ESo3LcI1cCOsopLv3Goa8rnRV4r2GvVIpC5man11Nb1eybqnBwtSbnkojgEPmB1+K8klmXacjuu0ffNOtbE6Oghtdx6VqSrDpAc3/9OH4/S8mG/xiMU3ipx8kf8bZW/EGG0z8psnB2uluwtm6067tw2z96QY1nsdkj8pxAd26Bt1Gr+Uw/QLjTT/MP8wYKGJ53utZsQw==',
  }

  file { '/home/zvercodebender':
    ensure  => 'directory',
    owner   => 'zvercodebender',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[zvercodebender], Group[puppet] ],
  }

  user { 'zvercodebender':
    ensure     => 'present',
    home       => '/home/zvercodebender',
    comment    => '8',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2616',
    managehome => true,
  }

  ssh_authorized_key { 'rick@goofy':
    user       => 'zvercodebender',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC0fBYDNGarDtTTOhNMpvDO7mcCPrV78X4KiYfYFY0N1MTe+yKKhNpRcFx/0irG0/64TXMadUJz5j0kXlVJuQsn+TwYRbRMKIinMysnPqf4l+4J2T9yIjUjfCZN9vv/CixANlaDB9KgQdsvXVg1EL+AsN2qnrl+AEXUZ1jAIV65FBQbmLfzsndrKw90qD2MOtn7UW62NAGD+bzADcJwisWpzq52TpKW/F5KgoL6ni8bW97IFNnWte9EUikgNq+RrfByiIAyCDw/MQ42yrFj96aKHeeZYnodX0aaCHcH/PY4y6EBl+i+mQ1uAaMMdul1LKs08EaX5jJb5+7NrLnsl6/n', 
  }

  file { '/home/dsvarmette':
    ensure  => 'directory',
    owner   => 'dsvarmette',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[dsvarmette], Group[puppet] ],
  }

  user { 'dsvarmette':
    ensure     => 'present',
    home       => '/home/dsvarmette',
    comment    => '8',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2617',
    managehome => true,
  }

  ssh_authorized_key { 'dsvarmette@ra.rockwell.com':
    user       => 'dsvarmette',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDCa6O4Df2s/YMiT5iPZunJXJ0qqq5HIEt69JHwlI23C4H/1HDteX7iotsAGppuuc3EEVYpnzGkOlaplf9p7Ced88G3Yf+vBI1z2+J+brVTK4QZOODmzEcm7i0PrHXRfojapBsOLJwu5FJANxvyGaYfUMH4yAgzNnINRm8VepfOPnWqjvtlI4ufePwUVlkaEk59GZNZFaF7XldRCIJJO/d8fpC1L/rWqZzi66/62+gG9jD/9nHXMCJVJTGhbTDkW9/FBOceOG5zqXo8byFtDQK8PjTsNOWC+3E2P8wZjYkxi31rymI18/KcjXzU+iFP7rZ/Qx0hZNf/y5uTOob7qbPl',
  } 

  file { '/home/grassfedphil':
    ensure  => 'directory',
    owner   => 'grassfedphil',
    group   => 'puppet',
    mode    => '0750',
    require => [ User[grassfedphil], Group[puppet] ],
  }

  user { 'grassfedphil':
    ensure     => 'present',
    home       => '/home/grassfedphil',
    comment    => '8',
    groups     => notice( $groups ),
    gid        => '666',
    shell      => '/bin/bash',
    uid        => '2618',
    managehome => true,
  }

  ssh_authorized_key { 'parlihpb@gmail.com':
    user       => 'grassfedphil',
    type       => 'ssh-rsa',
    key        => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQCrDV5OKeR5WRX7wovzFxSu9ObgEcHsB7jQzZRTAzfqpnK8c81mWIGSLJPyrJdXntfJcR/Etb2rulj3zm46fbGqBneJDVZBbIRgLJOxAIBW0zUjQetxXL66gtV5d6NO2WZJIkPG746FK4kRPK2igmiE5j2FTYiTHlCO4KUO/WjUx0eJ8ay+MuVe/8Lei0QfzDvCXmlChnfiQmCoHXUNMt8R4KEL5S1Dezyp9yG1UErL9uNUv64knTt6jW3am2ENCX9p26I8jHVmXDFmdnaUclNAPAAgCsV1B1qd+1Fr3hoxNZZ7xH5DQravWAZTHFCOyE0CtbmTeN44q8mfBRqI2gH93HCLHy9Fgqxa2Lc3fXkMDNuyUAZPjHtKwTHHSQXl9tapgF0IghJlUZolg14g4wnmIxy37uKQEMgzoo2EnfFnxD2IqpV001dwSXEOomtfBK/MD9FdSoZO0UW2M8nWOfGgOFOuSymfwdPovOSQtCyvgDMhvPpmdp+vJ0eXO5NZPFbcPx2Xu+NggdutFsd4TgUe5wG+YcW8xkBhEZFjA1OMrk02hMH3P/5pHzz3wxDitHK0ATwD5RFM+JzPnjU26ZfO2I9WEjaT4ZWKxOnHT+QM9ycx2WRE5JPaqG3KuhMIlc9sNted4i+xMrH7f7VaOfJ1D9Ltc0qgfUKMbpo9P8LluQ==',
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
