# Installs RackTables
class racktables::install (
  $secretfile  = $::racktables::secretfile,
  $release     = $::racktables::release,
  $datadir     = $::racktables::datadir,
  $apacheuser  = $::racktables::apacheuser,
  $packages    = $::racktables::packages,
  $vcsprovider = $::racktables::vcsprovider,
  $source      = $::racktables::source,
) {

  package { $packages :
    ensure => present,
  }

  package { $vcsprovider :
    ensure => present,
  }

  # Pull RackTables from source
  if $release == undef {
    vcsrepo { $datadir:
      ensure   => present,
      provider => $vcsprovider,
      source   => $source,
      require  => Package[$vcsprovider],
    }
  }
  else {
    vcsrepo { $datadir :
      ensure   => latest,
      provider => $vcsprovider,
      source   => $source,
      revision => $release,
      require  => Package[$vcsprovider],
    }
  }

  # Handle secret file
  case $secretfile {

    default: { # No action
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

}
