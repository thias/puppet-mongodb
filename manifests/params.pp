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
  # template & pidfilepath
  case $::operatingsystem {
    'RedHat','CentOS': {
      if versioncmp($::operatingsystemrelease, '7') >= 0 {
        $template = "${module_name}/mongodb-2.6.conf.erb"
        $pidfilepath = '/var/run/mongodb/mongod.pid'
      } else {
        $template = "${module_name}/mongodb-2.4.conf.erb"
        $pidfilepath = '/var/run/mongodb/mongodb.pid'
      }
    }
    default: {
      $template = "${module_name}/mongodb-2.4.conf.erb"
      $pidfilepath = '/var/run/mongodb/mongodb.pid'
    }
  }
  # package
  case $::operatingsystem {
    'Gentoo': { $package = 'dev-db/mongodb' }
    default:  { $package = [ 'mongodb', 'mongodb-server' ] }
  }
}

