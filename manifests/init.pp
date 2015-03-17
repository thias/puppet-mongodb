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
  # Just in case you wonder : quoted 'false' is for true/false text to be
  # set in the configuration file.
  $logpath        = $::mongodb::params::logpath,
  $bind_ip        = '127.0.0.1',
  $port           = '27017',
  $dbpath         = '/var/lib/mongodb',
  $auth           = undef,
  $verbose        = undef,
  $objcheck       = undef,
  $quota          = undef,
  $oplog          = undef,
  $slave          = undef,
  $master         = undef,
  $source         = undef,
  $pairwith       = undef,
  $arbiter        = undef,
  $autoresync     = undef,
  $oplogsize      = undef,
  $opidmem        = undef,
  $rest           = undef,
  $replset        = undef,
  $keyfile        = undef,
  $smallfiles     = undef,
  $extra_options  = {},
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

}

