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
  $mongod_version = "$::mongod_version",
) {
  # progname for config, pid and log file as it differs sometime
  case $::operatingsystem {
    'RedHat','CentOS': {
      if (versioncmp("$::operatingsystemrelease", '7') >= 0 or versioncmp("$mongod_version", '2.6') >= 0) {
          $progname = 'mongod'
      } else {
          $progname = 'mongodb'
      }
    }
    default: {
          $progname = 'mongodb'
    }
  }

  # service
  case $::operatingsystem {
    'RedHat','CentOS': {
      $service = "mongod"
    }
    default: {
      $service = "${progname}"
    }
  }

  # template 
	if versioncmp("$mongod_version", '3.0') >= 0 {
	  $template = "${module_name}/mongod-3.0.conf.erb"
	} elsif versioncmp("$mongod_version", '2.6') >= 0 {
	  $template = "${module_name}/mongod-2.6.conf.erb"
	} else {
    $template = "${module_name}/mongodb-2.4.conf.erb"
	}

  # conffile, pidfilepath & logpath
  case $::operatingsystem {
    'RedHat','CentOS': {
      $conffile = "/etc/${progname}.conf"
      $pidfilepath = "/var/run/mongodb/${progname}.pid"
      $logpath = "/var/log/mongodb/${progname}.log"
    }
    default: {
      $conffile = "/etc/${progname}.conf"
      $pidfilepath = '/var/run/mongodb/mongodb.pid'
      $logpath = '/var/log/mongodb/mongodb.log'
    }
  }

  # package
  case $::operatingsystem {
    'Gentoo': { $package = 'dev-db/mongodb' }
    default:  { $package = [ "mongodb", "mongodb-server" ] }
  }
}
