# Installs MySQL and RackTables database
class racktables::mysql (
  $mysqlrootpw = $::racktables::mysqlrootpw,
  $mysqldb     = $::racktables::mysqldb,
  $mysqluser   = $::racktables::mysqluser,
  $mysqluserpw = $::racktables::mysqluserpw,
  $mysqlhost   = $::racktables::mysqlhost,
) {

  validate_string($mysqlrootpw)
  validate_string($mysqluser)
  validate_string($mysqluserpw)
  validate_string($mysqldb)
  validate_string($mysqlhost)

  class { '::mysql::server':
    root_password => $mysqlrootpw,
  }

  mysql::db { $mysqldb :
    user     => $mysqluser,
    password => $mysqluserpw,
    host     => $mysqlhost,
    charset  => 'utf8',
    collate  => 'utf8_unicode_ci',
    grant    => ['ALL'],
  }

}
