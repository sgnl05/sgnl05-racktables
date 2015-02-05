#
class racktables::install inherits racktables {

  case $::osfamily {

    'RedHat': {
      package { [
        $vcsprovider,
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
      $vcsprovider,
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
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }

  }

  # Pull RackTables from source
  if $release == undef {
    vcsrepo { $datadir:
      ensure   => present,
      provider => $vcsprovider,
      source   => $source,
    }
  }
  else {
    vcsrepo { $datadir:
      ensure   => latest,
      provider => $vcsprovider,
      source   => $source,
      revision => $release,
    }
  }

  # Handle secret file
  case $secretfile {

    default: {
      # No action
    }
  
    'readable', 'readonly', 'read', 'r': {
    file { "${datadir}/wwwroot/inc/secret.php":
      ensure  => present,
      owner   => $apacheuser,
      mode    => '0400',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'httpd_sys_content_t',
      require => Vcsrepo[$datadir],
    }
  }

  'writable', 'writeable', 'write', 'w': {
    file { "${datadir}/wwwroot/inc/secret.php":
      ensure  => present,
      owner   => $apacheuser,
      mode    => '0600',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'httpd_sys_content_t',
      require => Vcsrepo[$datadir],
    }
  }

  'absent', 'delete': {
    file { "${datadir}/wwwroot/inc/secret.php":
      ensure => absent,
    }
  }

}
