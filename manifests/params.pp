# Class: nslcd::params
#
# This class defines default parameters used by the main module class nslcd
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to nslcd class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class nslcd::params {

  $uri = 'DNS'
  $base_dn = ''
  $ldap_version = '3'

  $bind_dn = ''
  $bind_pw = ''

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'libnss-ldapd',
  }

  $service = $::operatingsystem ? {
    default => 'nslcd',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'nslcd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'nslcd',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/nslcd.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/nslcd',
    default                   => '/etc/sysconfig/nslcd',
  }

  $pid_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/run/nslcd/nslcd.pid',
    default                   => '/var/run/nslcd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/messages',
  }

  $port = ''
  $protocol = ''

  # General Settings
  $my_class = ''
  $source = ''
  $template = 'nslcd/nslcd.conf.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
