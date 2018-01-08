# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/role/manifests/airlock.pp
class role::airlock {
  include profile::common
  include profile::users
  include profile::cron
  include profile::ntp
}
