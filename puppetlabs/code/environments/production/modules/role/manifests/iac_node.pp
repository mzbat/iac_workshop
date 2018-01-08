# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/role/manifests/iac_node.pp
class role::iac_node {
  include profile::common
  include profile::users
  include profile::modules
  include profile::cron
  include profile::ntp
  include profile::python
  include profile::elixir
}
