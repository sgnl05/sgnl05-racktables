# Installs RackTables
class racktables::config (
  $secretfile = $::racktables::secretfile,
  $datadir    = $::racktables::datadir,
  $apacheuser = $::racktables::apacheuser,
) {

  case $secretfile {

    'template': {
      file { "${datadir}/wwwroot/inc/secret.php":
        ensure  => present,
        owner   => $apacheuser,
        mode    => '0400',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'httpd_sys_content_t',
        content => template('racktables/secret.erb'),
        require => Vcsrepo[$datadir],
      }
    }

    /^r/: {
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

    /^w/: {
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

    default: { # No action
    }

  }

}
