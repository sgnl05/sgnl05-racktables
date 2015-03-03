# Installs RackTables
class racktables::install {

  case $::osfamily {

    'RedHat': {
      package { [
        $racktables::vcsprovider,
        'php-mysql',
        'php-ldap',
        'php-pdo',
        'php-gd',
        'php-snmp',
        'php-mbstring',
        'php-bcmath',
      ]:
        ensure => present,
      }
    }

    'Debian': {
      package { [
      $racktables::vcsprovider,
      'php5-gd',
      'php5-mysql',
      'php5-snmp',
      'php5-ldap',
      'php5-curl',
      ]:
        ensure => present,
      }
    }

    default: {
      fail("${module_name} module is not supported on osfamily ${::osfamily}.")
    }

  }

  # Pull RackTables from source
  if $racktables::release == undef {
    vcsrepo { $racktables::datadir:
      ensure   => present,
      provider => $racktables::vcsprovider,
      source   => $racktables::source,
    }
  }
  else {
    vcsrepo { $racktables::datadir:
      ensure   => latest,
      provider => $racktables::vcsprovider,
      source   => $racktables::source,
      revision => $racktables::release,
    }
  }

  # Handle secret file
  case $racktables::secretfile {

    default: {
      # No action
    }

    'readable', 'readonly', 'read', 'r': {
      file { "${racktables::datadir}/wwwroot/inc/secret.php":
        ensure  => present,
        owner   => $racktables::apacheuser,
        mode    => '0400',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_sys_content_t',
        require => Vcsrepo[$racktables::datadir],
      }
    }

    'writable', 'writeable', 'write', 'w': {
      file { "${racktables::datadir}/wwwroot/inc/secret.php":
        ensure  => present,
        owner   => $racktables::apacheuser,
        mode    => '0600',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_sys_content_t',
        require => Vcsrepo[$racktables::datadir],
      }
    }

    'absent', 'delete': {
      file { "${racktables::datadir}/wwwroot/inc/secret.php":
        ensure => absent,
      }
    }

  }

}
