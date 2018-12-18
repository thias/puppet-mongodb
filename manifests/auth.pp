# Class: mongodb::auth
#
# Allow basic management of users and roles
# by creating at least a root user
# and any extra users defined from a hash
# For instance:
#
# include mongodb::auth
# 
# class { 'mongodb::auth'
#   root_password: 'secret',
#   users: { foo: { password: 'secret', roles: '[ "readWrite" ]', dbname: 'foodata' } }
#
# The unix root user will be provided with a ~/.mongorc.js script
# which is required to support updating Mongo DB root password
#
class mongodb::auth (
  $root_password,
  $root_username  = 'root',
  $root_dbname    = 'admin',
  $users          = {},
) {
  require mongodb

  # Create mandatory root user with empty rc
  exec { 'mongo-rc-root-init':
    path    => [ '/bin', '/usr/bin', ],
    command => "echo '' > '/root/.mongorc.js'",
    unless  => "test -f '/root/.mongorc.js'",
  } ->

  mongodb::auth::user { "${root_username}":
    password  => "${root_password}",
    roles     => '[ "root" ]',
    login_username => '',
    login_password => '',
    local_username => 'root',
    local_userhome => '/root',
  }

  # Create optional users
  create_resources(mongodb::auth::user, $users)
}
