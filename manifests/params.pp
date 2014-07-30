#
class racktables::params {

  $vhost           = 'racktables.example.org'
  $secretwriteable = false
  $mysqlrootpw     = 'strongpassword'
  $mysqluser       = 'racktables_user'
  $mysqluserpw     = 'racktables_pass'
  $mysqldb         = 'racktables_db'
  $mysqlhost       = 'localhost'
  $vcsprovider     = 'git'
  $source          = 'https://github.com/RackTables/racktables.git'

  case $::osfamily {

    'RedHat': {
      $datadir    = '/usr/local/share/RackTables'
      $docdir     = '/usr/local/share/doc/RackTables'
      $apacheuser = 'apache'
    }

    'Debian': {
      $datadir    = '/usr/local/share/RackTables'
      $docdir     = '/usr/local/share/doc/RackTables'
      $apacheuser = 'www-data'
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }

  }

}
