# Class: virt_who
# ===========================
#
# Full description of class virt_who here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class virt_who (
  $package_name        = $::virt_who::params::package_name,
  $service_name        = $::virt_who::params::service_name,
  $service_ensure      = $::virt_who::params::service_ensure,
  $service_enable      = $::virt_who::params::service_enable,
  $server_hash         = {},
  $type                = $::virt_who::params::type,
  $username            = $::virt_who::params::username,
  $password            = $::virt_who::params::password,
  $encrypted_password  = $::virt_who::params::encrypted_password,
  $owner               = $::virt_who::params::owner,
  $env                 = $::virt_who::params::env,
  $hypervisor_id       = $::virt_who::params::hypervisor_id,
  $filter_host_parents = $::virt_who::params::filter_host_parents,
  $replace_config      = $::virt_who::params::replace_config,
  $purge_unmanaged     = $::virt_who::params::purge_unmanaged,
  $logrotate_schedule  = $::virt_who::params::logrotate_schedule,
  $logrotate_rotate    = $::virt_who::params::logrotate_rotate,
  $interval            = $::virt_who::params::interval,
) inherits ::virt_who::params {

  validate_string($package_name)
  validate_string($service_name)
  validate_re($service_ensure, '^true|false|running|stopped$')
  validate_re($service_enable, '^true|false|manual|mask$')
  validate_hash($server_hash)
  validate_re($type, '^libvirt|esx|hyperv|rhevm|vdsm|fake$')
  validate_string($username)
  if $password { validate_string($password) }
  elsif $encrypted_password { validate_string($encrypted_password) }
  else { fail( 'Either password or encrypted_password needs to be set' ) }
  if $owner { validate_string($owner) }
  if $env { validate_string($env) }
  if $hypervisor_id { validate_re($hypervisor_id, '^uuid|hostname|hwuuid$') }
  if $filter_host_parents { validate_array($filter_host_parents) }
  validate_bool($replace_config)
  validate_bool($purge_unmanaged)
  validate_string($logrotate_schedule)
  validate_integer($logrotate_rotate)
  validate_integer($interval)

  class { '::virt_who::install': } ->
  class { '::virt_who::config': } ~>
  class { '::virt_who::service': } ->
  Class['::virt_who']
}
