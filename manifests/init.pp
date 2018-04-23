# == Class: racktables
#
# === Examples
#
# class { '::racktables':
#   vhost   => 'racktables.example.com',
#   release => 'RackTables-0.20.10',
# }
#
# === Authors
#
# Gjermund Jensvoll <gjerjens@gmail.com>
#
# === Copyright
#
# Copyright 2014-2018 Gjermund Jensvoll
#
class racktables (
  $secretfile            = undef,
  $vhost                 = $racktables::params::vhost,
  $release               = undef,
  $install_db            = false,
  $db_username           = $racktables::params::db_username,
  $db_password           = $racktables::params::db_password,
  $db_name               = $racktables::params::db_name,
  $db_host               = $racktables::params::db_host,
  $db_rootpw             = undef,
  $db_grant              = $racktables::params::db_grant,
  $user_auth_src         = $racktables::params::user_auth_src,
  $require_local_account = $racktables::params::require_local_account,
  $pdo_bufsize           = undef,
  $ldap_options          = undef,
  $saml_options          = undef,
  $helpdesk_banner       = undef,
  $ssl_cert              = undef,
  $ssl_key               = undef,
  $ssl_chain             = undef,
  $templatefile          = $racktables::params::templatefile,
  $apacheuser            = $racktables::params::apacheuser,
  $datadir               = $racktables::params::datadir,
  $packages              = $racktables::params::packages,
  $repoensure            = $racktables::params::repoensure,
  $vcsprovider           = $racktables::params::vcsprovider,
  $source                = $racktables::params::source,
) inherits racktables::params {

  validate_string($vhost)
  validate_string($db_username)
  validate_string($db_password)
  validate_string($db_name)
  validate_string($db_host)
  validate_array($db_grant)
  validate_re($user_auth_src, '^(database|httpd|ldap|saml)$',
  "${user_auth_src} is not supported for user_auth_src.
  Allowed values are 'database', 'http', 'ldap' and 'saml'.")
  validate_bool($require_local_account)
  validate_string($pdo_bufsize)
  if $ldap_options != undef { validate_hash($ldap_options) }
  if $saml_options != undef { validate_hash($saml_options) }
  validate_string($helpdesk_banner)
  validate_absolute_path($datadir)

  if $install_db == true {
    class { '::racktables::mysql':
      db_username => $db_username,
      db_password => $db_password,
      db_name     => $db_name,
      db_host     => $db_host,
      db_rootpw   => $db_rootpw,
      db_grant    => $db_grant,
    }
  }

  class { '::racktables::apache':
    vhost     => $vhost,
    ssl_cert  => $ssl_cert,
    ssl_key   => $ssl_key,
    ssl_chain => $ssl_chain,
    datadir   => $datadir,
  }

  class { '::racktables::install':
    release     => $release,
    datadir     => $datadir,
    packages    => $packages,
    repoensure  => $repoensure,
    vcsprovider => $vcsprovider,
    source      => $source,
  }

  class { '::racktables::config':
    secretfile => $secretfile,
    datadir    => $datadir,
    apacheuser => $apacheuser,
  }

}
