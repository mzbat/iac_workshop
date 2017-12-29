# Set up puppet master

These are the files used to spin up the puppet master. 

They are included to give additional terraform examples.




## Connect to Puppet master

Before you start, get your public IP from a site like whatsmyip.com or run a command like so from your CLI: 

```
curl ipinfo.io/ip
```

This IP has to be added to firewall.tf before you do "terraform apply" 
or your SSH attempts will probably timeout. 


You can connect to the puppet master like so: 

```
ssh -i ~/.ssh/do_terra_rsa -l root -A 188.166.26.120
```

## Firewall 

The Puppet master server must allow incoming connections on 
port 8140, and agent nodes must be able to connect to the 
master on that port.

