# Params
class racktables::params {

  $vhost                 = 'racktables.example.org'
  $db_username           = 'racktables_user'
  $db_password           = 'racktables_pass'
  $db_name               = 'racktables_db'
  $db_host               = 'localhost'
  $db_grant              = ['ALL']
  $user_auth_src         = 'database'
  $require_local_account = true
  $templatefile          = 'racktables/secret.erb'
  $datadir               = '/usr/local/share/RackTables'
  $repoensure            = 'present'
  $vcsprovider           = 'git'
  $source                = 'https://github.com/RackTables/racktables.git'

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
