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
# class { '::racktables':
#   vhost       => 'racktables.example.com',
#   release     => 'RackTables-0.20.10',
#   mysqlrootpw => 'change.me123XXXabc',
# }
#
# === Authors
#
# Gjermund Jensvoll <gjerjens@gmail.com>
#
# === Copyright
#
# Copyright 2014-2015 Gjermund Jensvoll
#
class racktables (
  $secretfile  = $racktables::params::secretfile,
  $release     = $racktables::params::release,
  $vhost       = $racktables::params::vhost,
  $mysqlrootpw = $racktables::params::mysqlrootpw,
  $mysqluser   = $racktables::params::mysqluser,
  $mysqluserpw = $racktables::params::mysqluserpw,
  $mysqldb     = $racktables::params::mysqldb,
  $mysqlhost   = $racktables::params::mysqlhost,
  $datadir     = $racktables::params::datadir,
  $docdir      = $racktables::params::docdir,
  $apacheuser  = $racktables::params::apacheuser,
  $packages    = $racktables::params::packages,
  $vcsprovider = $racktables::params::vcsprovider,
  $source      = $racktables::params::source,
) inherits racktables::params {

  validate_string($secretfile)
  validate_string($release)
  validate_string($vhost)
  validate_string($mysqlrootpw)
  validate_string($mysqluser)
  validate_string($mysqluserpw)
  validate_string($mysqldb)
  validate_string($mysqlhost)
  validate_string($datadir)
  validate_string($docdir)
  validate_string($apacheuser)
  validate_array($packages)
  validate_string($vcsprovider)
  validate_string($source)

  class { '::racktables::install':
    secretfile  => $secretfile,
    release     => $release,
    datadir     => $datadir,
    apacheuser  => $apacheuser,
    packages    => $packages,
    vcsprovider => $vcsprovider,
    source      => $source,
  }

  class { '::racktables::mysql':
    mysqlrootpw => $mysqlrootpw,
    mysqldb     => $mysqldb,
    mysqluser   => $mysqluser,
    mysqluserpw => $mysqluserpw,
    mysqlhost   => $mysqlhost,
  }

  class { '::racktables::apache':
    vhost   => $vhost,
    datadir => $datadir,
  }

}
