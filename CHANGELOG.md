#### 2019-11-20 - 1.0.8
* Change systemd LimitNPROC default to 48000 (#9, @osgpcq).

#### 2019-01-21 - 1.0.7
* Skip backup when it's supposed to be (#6, @edupr91).

#### 2017-02-15 - 1.0.6
* Allow more compression options & post backup parameter (@forgodssake, #5).

#### 2016-09-12 - 1.0.5
* Fix port variable for 2.4 and 2.6 configs (@sp-borja-juncosa, #4).

#### 2016-06-13 - 1.0.4
* Add optional backup script and cron job (@forgodssake).
* Fix versioncmp (#3, @edupr91).

#### 2016-06-09 - 1.0.3
* Switch to the YAML configuration for 3.x to allow using wiredTiger engine.
* Add authorization option (#1, @forgodssake).

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

