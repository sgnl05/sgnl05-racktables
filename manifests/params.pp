# Params
class racktables::params {

  $vhost       = 'racktables.example.org'
  $mysqlrootpw = 'strongpassword'
  $mysqluser   = 'racktables_user'
  $mysqluserpw = 'racktables_pass'
  $mysqldb     = 'racktables_db'
  $mysqlhost   = 'localhost'
  $datadir     = '/usr/local/share/RackTables'
  $vcsprovider = 'git'
  $source      = 'https://github.com/RackTables/racktables.git'

  case $::osfamily {

    'RedHat': {
      $apacheuser = 'apache'
      $packages   = [
        'php-mysql',
        'php-ldap',
        'php-snmp',
        'php-pdo',
        'php-gd',
        'php-mbstring',
        'php-bcmath',
      ]

    }

    'Debian': {
      $apacheuser = 'www-data'
      $packages   = [
        'php5-mysql',
        'php5-ldap',
        'php5-snmp',
        'php5-gd',
        'php5-curl',
      ]
    }

    default: {
      fail("${module_name} module is not supported on osfamily ${::osfamily}.")
    }

  }

}
