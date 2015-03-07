# Params
class racktables::params {

  $secretfile  = undef
  $release     = undef
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
    }

    'Debian': {
      $apacheuser = 'www-data'
    }

    default: {
      fail("${module_name} module is not supported on osfamily ${::osfamily}.")
    }

  }

}
