# Installs MySQL and RackTables database
class racktables::mysql {

  class { '::mysql::server':
    root_password => $racktables::mysqlrootpw,
  }

  mysql::db { $racktables::mysqldb :
    user     => $racktables::mysqluser,
    password => $racktables::mysqluserpw,
    host     => $racktables::mysqlhost,
    charset  => 'utf8',
    collate  => 'utf8_unicode_ci',
    grant    => ['ALL'],
  }

}
