# Installs MySQL and RackTables database
class racktables::mysql (
  $db_username = $::racktables::db_username,
  $db_password = $::racktables::db_password,
  $db_name     = $::racktables::db_name,
  $db_host     = $::racktables::db_host,
  $db_rootpw   = $::racktables::db_rootpw,
  $db_grant    = $::racktables::db_grant,
) {

  validate_string($db_username)
  validate_string($db_password)
  validate_string($db_name)
  validate_string($db_host)
  validate_string($db_rootpw)
  validate_array($db_grant)

  class { '::mysql::server':
    root_password => $db_rootpw,
  }

  mysql::db { $db_name :
    user     => $db_username,
    password => $db_password,
    host     => $db_host,
    charset  => 'utf8',
    collate  => 'utf8_unicode_ci',
    grant    => $db_grant,
  }

}
