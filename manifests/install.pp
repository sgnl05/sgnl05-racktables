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
      ]:
        ensure => present,
      }
    }

    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }

  }

  vcsrepo { $datadir:
    ensure   => present,
    provider => $vcsprovider,
    source   => $source,
  }

  if $secretwriteable == true {

    file { "${datadir}/wwwroot/inc/secret.php":
      ensure  => present,
      owner   => $apacheuser,
      mode    => '0600',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'httpd_sys_content_t',
      require => vcsrepo[$datadir],
    }

  } else {

    file { "${datadir}/wwwroot/inc/secret.php":
      ensure  => present,
      owner   => $apacheuser,
      mode    => '0400',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'httpd_sys_content_t',
      require => vcsrepo[$datadir],
    }

  }

}
