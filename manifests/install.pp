# Installs RackTables
class racktables::install (
  $release     = $::racktables::release,
  $datadir     = $::racktables::datadir,
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

}
