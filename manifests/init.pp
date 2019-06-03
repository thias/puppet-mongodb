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
  $runpath        = $::mongodb::params::runpath,
  $pidfilepath    = $::mongodb::params::pidfilepath,
  # Just in case you wonder : quoted 'false' is for true/false text to be
  # set in the configuration file.
  $logpath        = $::mongodb::params::logpath,
  $owner          = $::mongodb::params::owner,
  $group          = $::mongodb::params::group,
  $bind_ip        = '127.0.0.1',
  $dbpath         = $::mongodb::params::dbpath,
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
  $storage_dbpath          = $::mongodb::params::dbpath,
  $storage_engine          = undef,
  $net_bindip              = '127.0.0.1',
  $net_port                = '27017',
  $authorization           = undef,
  $security_keyfile        = undef,
  $replication_oplogsizemb = undef,
  $replication_replsetname = undef,
  $set_parameter           = {},
  $scl_name       = $::mongodb::params::scl_name,
  $tools          = false, # do not install tools by default
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

  # Manage log directory, required if not same as package default
  $logdir = inline_template("<%= File.dirname(@logpath) %>")

  file { 'mongo-log-dir':
    path		=> $logdir,
    owner   => $owner,
    group   => $group,
    mode    => '0750',
    recurse => false,
    require => Package[$package],
    before  => Service[$service],
  }

  if ($tools) {
    if ($package_tools) {
    	package { $package_tools:
    	  ensure => 'installed',
        before => File['mongotools-wrapper'],
      }
    }

    file { 'mongotools-wrapper':
      path    => '/usr/local/bin/mongotools',
      content => template('mongodb/mongotools.erb'),
      mode    => '0755',
    } ->

    file { 'mongodump-lnk':
      path    => '/usr/local/bin/mongodump',
      ensure  => './mongotools',
    } ->

    file { 'mongorestore-lnk':
      path    => '/usr/local/bin/mongorestore',
      ensure  => './mongotools',
    }
  }
}
