# <ENVIRONMENTS DIRECTORY>/<ENVIRONMENT>/modules/profile/role/manifests/iac_node.pp
class role::iac_node {
  include profile::common
  include profile::users
}
