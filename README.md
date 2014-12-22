# puppet-mongodb

## Overview

Install, enable and configure the MongoDB scalable, high-performance NoSQL
database. This module is quite Red Hat Enterprise Linux (RHEL) or clones
(CentOS) specific, but should be easy to make more generic.

The default generated configuration file is meant to be as close a possible to
the one included in the Fedora/EPEL package.

* `mongodb` : Manage the MongoDB NoSQL server
* `mongodb::key` : Manage auth key file to be used for MongoDB replicas

## Examples

```puppet
class { '::mongodb':
  bind_ip => '0.0.0.0',
  verbose => 'true',
}
```

