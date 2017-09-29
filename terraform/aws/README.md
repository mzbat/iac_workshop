These are the same values you will find in the ~/.aws/credentials file.

  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
This are your personal, private credentials for amazon. You can save them locally
but be sure not to push to github, etc. The .gitignore file is configure to prevent
you from committing your private creds to github but please take care to double 
check this does not happen.


Example:
```
aws_access_key = "KLJAHSDFKJASHDLKJASHD"
aws_secret_key = "ljasd\fjlkjasdfl\kjasdflkajd98345"
```

* Update the public SSH key half in variables.tf

Edit the "key_name" and "key_path" variables in the file variables.tf

* apply the puppet configuration

Finally, you run puppet to apply the configuration to the host.

```
sudo /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
```
