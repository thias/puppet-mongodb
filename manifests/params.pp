# Class: mongodb::params
#
# Parameters for and from the mongodb module.
#
# Parameters :
#  none
#
# Sample Usage :
#  include mongodb::params
#
class mongodb::params {
  # The easy one
  $conffile = '/etc/mongodb.conf'
  # service
  case $::operatingsystem {
    'Debian','Ubuntu': {
      $service = 'mongodb'
    }
    default: {
      $service = 'mongod'
    }
  }
  # package
  case $::operatingsystem {
    'Gentoo': { $package = 'dev-db/mongodb' }
    default:  { $package = 'mongodb-server' }
  }
}

