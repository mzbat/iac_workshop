## Install required gems

```  
gem install puppet
gem install puppet-lint
gem install rspec-puppet
```

## Make sure you have a metadata.json file

Use the guide located here: 
[https://puppet.com/docs/puppet/5.3/modules_metadata.html](https://puppet.com/docs/puppet/5.3/modules_metadata.html)

## Now initialize it

```
root@puppet:./lamp# rspec-puppet-init
 + spec/
 + spec/classes/
 + spec/defines/
 + spec/functions/
 + spec/hosts/
 + spec/fixtures/
 + spec/fixtures/manifests/
 + spec/fixtures/modules/
 + spec/fixtures/modules/lamp
 + spec/fixtures/manifests/site.pp
 + spec/spec_helper.rb
 + Rakefile
```
