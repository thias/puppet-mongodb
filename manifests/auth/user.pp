# Define: mongodb::auth::user
#
# Example Usage:
#   mongodb::auth::user { foo:
#     password => 'secret',
#     dbname   => 'foodata',
#     roles:   => '[ "readWrite" ]',
#   }
#
# REM: roles need to be passed as a valid JSON string
# For more info about the syntax:
#   https://docs.mongodb.com/manual/reference/command/createRole/#roles
#
# In case local_username is set, the corresponding user
# will be provided with a ~/.mongorc.js script to automate
# its login when starting the Mongo shell
# 
define mongodb::auth::user (
  $password,
  $username = "$name",
  $dbname   = 'admin',
  $ensure   = 'present',
  $roles		= '[ "readWriteAnyDatabase" ]',
  $scl_name = "$mongodb::scl_name",
  $login_username = "$mongodb::auth::root_username",
  $login_password = "$mongodb::auth::root_password",
  $login_dbname = "$mongodb::auth::root_dbname",
  $local_username	= false,
  $local_userhome = false,
) {
  include mongodb::auth

  $net_port = $mongodb::net_port

  # Construct the correct command line to call Mongo shell
  if ($scl_name) {
    $mongo_cmd = "scl enable ${scl_name} -- mongo --quiet --port $net_port"
  } else {
    $mongo_cmd = "mongo --quiet --port $net_port"
  }

  # Construct login arguments if relevant
  if ($login_username) { 
    $mongo_user_arg = " -u '${login_username}'"
  }
  if ($login_password) {
    $mongo_pwd_arg = " -p '${login_password}'"
  }
  if ($login_dbname) {
    $mongo_db_arg = "'${login_dbname}'"
  }

  Exec {
    path => [ '/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin', ],
  }

  case $ensure {
    'absent': {
      # FIXME
    }
    'present': {
      $script = template('mongodb/auth/user.js.erb')

		  exec { "user-${username}":
		    provider => 'shell',
		    command => "{ cat /root/.mongorc.js; cat <<EOF
${script}
EOF
} | ${mongo_cmd} ${mongo_db_arg}",
        unless  => "${mongo_cmd} -u ${username} -p ${password} ${dbname}",
        logoutput => on_failure,
		  }

      if ($local_userhome) {
        $rc_path = "$local_userhome/.mongorc.js"
      } else {
        $rc_path = "/home/${local_username}/.mongorc.js"
      }

      if ($local_username) {
        file { "mongo-rc-${local_username}":
          path      => "${rc_path}",
          content   => template('mongodb/auth/rc.js.erb'),
          owner     => "${local_username}",
          mode      => '0600',
          require   => Exec["user-${username}"],
          show_diff => false,
        }
      }
		}
    default: {
      notice('Unknown value for ensure')
    }
  }
}
