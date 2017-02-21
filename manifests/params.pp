# == Class virt_who::params
#
# This class is meant to be called from virt_who.
# It sets variables according to platform.
#
class virt_who::params {
  $service_ensure      = 'running'
  # lint:ignore:quoted_booleans
  $service_enable      = 'true'
  # lint:endignore
  $type                = 'esx'
  $username            = undef
  $password            = undef
  $encrypted_password  = undef
  $owner               = 'admin'
  $env                 = 'Library'
  $hypervisor_id       = 'hostname'
  $filter_host_parents = undef
  $replace_config      = true
  $purge_unmanaged     = true
  $logrotate_schedule  = 'daily'
  $logrotate_rotate    = 2
  $interval            = 3600
  case $::osfamily {
    'RedHat': {
      $package_name = 'virt-who'
      $service_name = 'virt-who'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
