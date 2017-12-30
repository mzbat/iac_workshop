# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/manifests/site.pp
node default {
  hiera_include('classes')
}
