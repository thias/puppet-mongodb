#### 2015-04-01 - 1.0.2
* Add mongod_version fact.
* Add mongod.conf template from 3.0.0.

#### 2014-12-22 - 1.0.1
* Lowercase parameters in missing places.

#### 2014-12-22 - 1.0.0
* Add conf template for 2.6 (RHEL7).
* Lowercase all parameters, and default them to undef.
* Add extra_options hash to set any options in the conf file.
* Install the client package too.
* Fix require and notify in the key definition.
* Cosmetic cleanups.

#### 2013-06-13 - 0.1.2
* Fix the service name for Debian and Ubuntu.

#### 2013-05-20 - 0.1.1
* Add support for overriding package, service and configuration file names.
* Update README and use markdown
* Change to 2-space indent

#### 2012-12-18 - 0.1.0
* Add replSet option.
* Use undef by default instead of false where we want the defaults to apply
* Add rest, keyFile, smallfiles options.
* Add mongodb::key definition for installing rs keys.

#### 2012-04-23 - 0.0.2
* Add basic support for enabling auth.

#### 2012-04-20 - 0.0.1
* Initial release.

