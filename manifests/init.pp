# Class: mongodb
#
# Install, enable and configure the MongoDB scalable, high-performance NoSQL
# database.
#
# Parameters:
#  See the comments in the included mongodb.conf.
#
# Sample Usage :
#  include mongodb
#  class { 'mongodb':
#    bind_ip => '0.0.0.0',
#    verbose => 'true',
#  }
#
class mongodb (
  # From the params
  $service        = $::mongodb::params::service,
  $conffile       = $::mongodb::params::conffile,
  $package        = $::mongodb::params::package,
  $template       = $::mongodb::params::template,
  $pidfilepath    = $::mongodb::params::pidfilepath,
  $with_systemd   = $::mongodb::params::with_systemd,
  # Just in case you wonder : quoted 'false' is for true/false text to be
  # set in the configuration file.
  $logpath        = $::mongodb::params::logpath,
  $bind_ip        = '127.0.0.1',
  $dbpath         = '/var/lib/mongodb',
  $auth           = undef,
  $verbose        = undef, # old
  $verbosity      = undef, # new yaml
  $objcheck       = undef,
  $quota          = undef,
  $oplog          = undef,
  $slave          = undef,
  $master         = undef,
  $source         = undef,
  $pairwith       = undef,
  $arbiter        = undef,
  $autoresync     = undef,
  $oplogsize      = undef, # old
  $oplogsizemb    = undef, # new yaml
  $opidmem        = undef,
  $rest           = undef,
  $replset        = undef, # old
  $replsetname    = undef, # new yaml
  $keyfile        = undef,
  $smallfiles     = undef,
  $extra_options  = {},
  # New YAML configuration
  $systemlog_verbosity     = undef,
  $storage_dbpath          = '/var/lib/mongodb',
  $storage_engine          = undef,
  $net_bindip              = '127.0.0.1',
  $net_port                = '27017',
  $authorization           = undef,
  $security_keyfile        = undef,
  $replication_oplogsizemb = undef,
  $replication_replsetname = undef,
  $mongo_LimitNPROC        = '48000',
  
) inherits ::mongodb::params {

  # Main package and service
  package { $package: ensure => 'installed' }
  service { $service:
    ensure    => 'running',
    enable    => true,
    hasstatus => true,
    subscribe => File[$conffile],
    require   => Package[$package],
  }

  # Main configuration file
  file { $conffile:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($template),
    require => Package[$package],
  }
  if $with_systemd {
    exec { 'mongodb systemctl daemon-reload':
      command     => 'systemctl daemon-reload',
      path        => $::path,
      refreshonly => true,
    }
    file { "/etc/systemd/system/${service}.service.d":
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
    file { "/etc/systemd/system/${service}.service.d/${service}.conf":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "[Service]\nLimitNPROC=${mongo_LimitNPROC}\n",
      notify  => Exec['mongodb systemctl daemon-reload'],
    }
  }

}

