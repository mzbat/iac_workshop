file {'/tmp/it_works.txt':                        # resource type file and filename
  ensure  => present,                             # make sure it exists
  mode    => '0644',                              # file permissions
  content => "It works on ${ipaddress_eth0}!\n",  # Print the eth0 IP fact
}

