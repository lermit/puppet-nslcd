# = Class: nslcd
#
# This is the main nslcd class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, nslcd class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $nslcd_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, nslcd main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $nslcd_source
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, nslcd main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $nslcd_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $nslcd_options
#
# [*service_autorestart*]
#   Automatically restarts the nslcd service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $nslcd_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $nslcd_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $nslcd_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $nslcd_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for nslcd checks
#   Can be defined also by the (top scope) variables $nslcd_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $nslcd_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $nslcd_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $nslcd_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $nslcd_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $nslcd_audit_only
#   and $audit_only
#
# Default class params - As defined in nslcd::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of nslcd package
#
# [*service*]
#   The name of nslcd service
#
# [*service_status*]
#   If the nslcd service init script supports status argument
#
# [*process*]
#   The name of nslcd process
#
# [*process_args*]
#   The name of nslcd arguments. Used by puppi and monitor.
#   Used only in case the nslcd process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user nslcd runs with. Used by puppi and monitor.
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include nslcd"
# - Call nslcd as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class nslcd (
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $uri                 = params_lookup( 'uri' ),
  $base_dn             = params_lookup( 'base_dn' ),
  $ldap_version        = params_lookup( 'ldap_version' ),
  $bind_dn             = params_lookup( 'bind_dn' ),
  $bind_pw             = params_lookup( 'bind_pw' )
  ) inherits nslcd::params {

  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $nslcd::bool_absent ? {
    true  => 'absent',
    false => $nslcd::version,
  }

  $manage_service_enable = $nslcd::bool_disableboot ? {
    true    => false,
    default => $nslcd::bool_disable ? {
      true    => false,
      default => $nslcd::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $nslcd::bool_disable ? {
    true    => 'stopped',
    default =>  $nslcd::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $nslcd::bool_service_autorestart ? {
    true    => Service[nslcd],
    false   => undef,
  }

  $manage_file = $nslcd::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $nslcd::bool_absent == true
  or $nslcd::bool_disable == true
  or $nslcd::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $nslcd::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $nslcd::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $nslcd::source ? {
    ''        => undef,
    default   => $nslcd::source,
  }

  $manage_file_content = $nslcd::template ? {
    ''        => undef,
    default   => template($nslcd::template),
  }

  ### Managed resources
  package { 'nslcd':
    ensure => $nslcd::manage_package,
    name   => $nslcd::package,
  }

  service { 'nslcd':
    ensure     => $nslcd::manage_service_ensure,
    name       => $nslcd::service,
    enable     => $nslcd::manage_service_enable,
    hasstatus  => $nslcd::service_status,
    pattern    => $nslcd::process,
    require    => Package['nslcd'],
  }

  file { 'nslcd.conf':
    ensure  => $nslcd::manage_file,
    path    => $nslcd::config_file,
    mode    => $nslcd::config_file_mode,
    owner   => $nslcd::config_file_owner,
    group   => $nslcd::config_file_group,
    require => Package['nslcd'],
    notify  => $nslcd::manage_service_autorestart,
    source  => $nslcd::manage_file_source,
    content => $nslcd::manage_file_content,
    replace => $nslcd::manage_file_replace,
    audit   => $nslcd::manage_audit,
  }

  ### Include custom class if $my_class is set
  if $nslcd::my_class {
    include $nslcd::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $nslcd::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'nslcd':
      ensure    => $nslcd::manage_file,
      variables => $classvars,
      helper    => $nslcd::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $nslcd::bool_monitor == true {
    monitor::process { 'nslcd_process':
      process  => $nslcd::process,
      service  => $nslcd::service,
      pidfile  => $nslcd::pid_file,
      user     => $nslcd::process_user,
      argument => $nslcd::process_args,
      tool     => $nslcd::monitor_tool,
      enable   => $nslcd::manage_monitor,
    }
  }

  ### Debugging, if enabled ( debug => true )
  if $nslcd::bool_debug == true {
    file { 'debug_nslcd':
      ensure  => $nslcd::manage_file,
      path    => "${settings::vardir}/debug-nslcd",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
