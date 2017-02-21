# == Class virt_who::install
#
# This class is called from virt_who for install.
#
class virt_who::install {

  package { $::virt_who::package_name:
    ensure => present,
  }
}
