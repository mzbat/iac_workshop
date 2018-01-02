## Troubleshoot

* From the agent, pull in the latest:

```
puppet agent -t --verbose --debug
```

* Verify the role:
```
sudo facter -p role
```

* Now use  this for facter and hiera:

```
puppet lookup classes  --explain --merge unique
```
