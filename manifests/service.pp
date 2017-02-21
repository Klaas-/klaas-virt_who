# == Class virt_who::service
#
# This class is meant to be called from virt_who.
# It ensure the service is running.
#
class virt_who::service {

  service { $::virt_who::service_name:
    ensure     => $::virt_who::service_ensure,
    enable     => $::virt_who::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
