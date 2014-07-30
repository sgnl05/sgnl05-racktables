# == Class: racktables
#
# Full description of class racktables here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { racktables:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class racktables (
  $secretwriteable = $racktables::params::secretwriteable,
  $vhost           = $racktables::params::vhost,
  $mysqlrootpw     = $racktables::params::mysqlrootpw,
  $mysqluser       = $racktables::params::mysqluser,
  $mysqluserpw     = $racktables::params::mysqluserpw,
  $mysqldb         = $racktables::params::mysqldb,
  $mysqlhost       = $racktables::params::mysqlhost,
  $datadir         = $racktables::params::datadir,
  $docdir          = $racktables::params::docdir,
  $apacheuser      = $racktables::params::apacheuser,
  $vcsprovider     = $racktables::params::vcsprovider,
  $source          = $racktables::params::source,

) inherits racktables::params {

  validate_bool($secretwriteable)
  validate_string($vhost)
  validate_string($mysqlrootpw)
  validate_string($mysqluser)
  validate_string($mysqluserpw)
  validate_string($mysqldb)
  validate_string($mysqlhost)
  validate_string($datadir)
  validate_string($docdir)
  validate_string($apacheuser)
  validate_string($vcsprovider)
  validate_string($source)


  class { '::racktables::install': }
  class { '::racktables::apache': }
  class { '::racktables::mysql': }

}
