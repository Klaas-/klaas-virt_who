# == Class virt_who::config
#
# This class is called from virt_who for service config.
#
class virt_who::config {
  $defaults = {
    'type'                => $::virt_who::type,
    'username'            => $::virt_who::username,
    'password'            => $::virt_who::password,
    'encrypted_password'  => $::virt_who::encrypted_password,
    'owner'               => $::virt_who::owner,
    'env'                 => $::virt_who::env,
    'hypervisor_id'       => $::virt_who::hypervisor_id,
    'filter_host_parents' => $::virt_who::filter_host_parents,
    'replace_config'      => $::virt_who::replace_config,
  }
  # Untested if anyone is still using puppet 3.x test it, build a proper conditional and pr it :)
  #create_resources(virt_who::config_file , $::virt_who::server_hash, $defaults)
  $::virt_who::server_hash.each |String $resource, Hash $attributes| {
    virt_who::config_file {
      default:   * => $defaults;
      $resource: * => $attributes;
    }
  }

  if $::virt_who::purge_unmanaged {
    file { '/etc/virt-who.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
    }
  }

  augeas { 'virt-who logrotate':
    context => '/files/etc/logrotate.d/subscription-manager',
    changes => [
      "set rule[file='/var/log/rhsm/*.log']/schedule ${virt_who::logrotate_schedule}",
      "set rule[file='/var/log/rhsm/*.log']/rotate ${virt_who::logrotate_rotate}",
      ],
  }

  augeas { 'virt-who interval':
    context => '/files/etc/sysconfig/virt-who',
    changes => "set VIRTWHO_INTERVAL ${virt_who::interval}",
  }
}
