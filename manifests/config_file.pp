# == Class virt_who::config_file
#
# This class is called from virt_who for service config.
#
define virt_who::config_file (
  $replace_config,
  $type,
  $username,
  $password,
  $encrypted_password,
  $owner,
  $env,
  $hypervisor_id,
  $filter_host_parents,
  $server = $name,
) {
  file { "/etc/virt-who.d/${server}.conf" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('virt_who/config.erb'),
    replace => $replace_config,
  }
}
