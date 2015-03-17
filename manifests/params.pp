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
class mongodb::params (
  $mongod_version = $::mongod_version,
) {
  # service
  case $::operatingsystem {
    'Debian','Ubuntu': {
      $service = 'mongodb'
    }
    default: {
      $service = 'mongod'
    }
  }
  # template & pidfilepath & logpath
  case $::operatingsystem {
    'RedHat','CentOS': {
      if versioncmp($::operatingsystemrelease, '7') >= 0 {
        if versioncmp($::mongod_version, '3') >= 0 {
          $conffile = '/etc/mongod.conf'
          $template = "${module_name}/mongod-3.0.conf.erb"
        } else {
          $conffile = '/etc/mongodb.conf'
          $template = "${module_name}/mongodb-2.6.conf.erb"
        }
        $pidfilepath = '/var/run/mongodb/mongod.pid'
        $logpath = '/var/log/mongodb/mongod.log'
      } else {
        $conffile = '/etc/mongodb.conf'
        $template = "${module_name}/mongodb-2.4.conf.erb"
        $pidfilepath = '/var/run/mongodb/mongodb.pid'
        $logpath = '/var/log/mongodb/mongodb.log'
      }
    }
    default: {
      $conffile = '/etc/mongodb.conf'
      $template = "${module_name}/mongodb-2.4.conf.erb"
      $pidfilepath = '/var/run/mongodb/mongodb.pid'
      $logpath = '/var/log/mongodb/mongodb.log'
    }
  }
  # package
  case $::operatingsystem {
    'Gentoo': { $package = 'dev-db/mongodb' }
    default:  { $package = [ 'mongodb', 'mongodb-server' ] }
  }
}

