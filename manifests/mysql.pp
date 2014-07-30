#
class racktables::mysql inherits racktables {

  class { '::mysql::server':
    root_password => "$mysqlrootpw",
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
