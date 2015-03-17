# puppet-mongodb

## Overview

Install, enable and configure the MongoDB scalable, high-performance NoSQL
database. This module is quite Red Hat Enterprise Linux (RHEL) or clones
(CentOS) specific, but should be easy to make more generic. It's meant to be
simple, to manage only the service's configuration (not the MongoDB resources
themselves) and to not have any external module dependencies.

The default generated configuration file is meant to be as close a possible to
the one included in the Fedora/EPEL packages.

* `mongodb` : Manage the MongoDB NoSQL server
* `mongodb::key` : Manage auth key file to be used for MongoDB replicas

## Examples

```puppet
mongodb::key { '/etc/mongodb.key':
  content => 'c9otjehasAvlactocPiphAgC9',
}
class { '::mongodb':
  bind_ip => '0.0.0.0',
  auth    => 'true',
  rest    => 'true',
  replset => 'rs0',
  keyfile => '/etc/mongodb.key',
}
```

