# Installs MySQL and RackTables database
class racktables::mysql (
  $mysqlrootpw = $racktables::params::mysqlrootpw,
  $mysqldb     = $racktables::params::mysqldb,
  $mysqluser   = $racktables::params::mysqluser,
  $mysqluserpw = $racktables::params::mysqluserpw,
  $mysqlhost   = $racktables::params::mysqlhost,
) inherits racktables::params {

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
