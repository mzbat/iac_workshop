# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/role/manifests/airlock.pp
class role::airlock {
  include profile::common
  include profile::debian_users
}
