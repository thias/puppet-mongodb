# Define: mongodb::key
#
# Example Usage:
#   mongodb::key { '/etc/mongodb.key': content => 'foo' }
#
define mongodb::key (
  $content = undef,
  $source  = undef,
  $ensure  = undef,
) {

  include '::mongodb::params'

  file { $title:
    ensure  => $ensure,
    content => $content,
    source  => $source,
    owner   => 'mongodb',
    group   => 'mongodb',
    # mongod requires 0600, anything more relaxed won't work
    mode    => '0600',
    require => Package[$::mongodb::params::package],
    notify  => Service[$::mongodb::params::service],
  }

}

