# https://collectd.org/wiki/index.php/Plugin:IPTables
class collectd::plugin::iptables (
  $ensure         = 'present',
  $ensure_package = 'present',
  $manage_package = undef,
  $chains         = {},
  $chains6        = {},
  $interval       = undef,
) {

  include ::collectd

  $_manage_package = pick($manage_package, $::collectd::manage_package)

  validate_hash($chains)
  validate_hash($chains6)

  if $::osfamily == 'RedHat' {
    if $_manage_package {
      package { 'collectd-iptables':
        ensure => $ensure_package,
      }
    }
  }

  collectd::plugin { 'iptables':
    ensure   => $ensure,
    content  => template('collectd/plugin/iptables.conf.erb'),
    interval => $interval,
  }
}
