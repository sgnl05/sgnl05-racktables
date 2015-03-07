# Installs RackTables
class racktables::install (
  $release     = $::racktables::release,
  $datadir     = $::racktables::datadir,
  $packages    = $::racktables::packages,
  $repoensure  = $::racktables::repoensure,
  $vcsprovider = $::racktables::vcsprovider,
  $source      = $::racktables::source,
) {

  validate_re($repoensure, '^(present|latest)$',
  "${repoensure} is not supported for repoensure.
  Allowed values are 'present' and 'latest'.")

  package { $packages :
    ensure => present,
  }

  package { $vcsprovider :
    ensure => present,
  }

  # Pull RackTables from source
  if $release == undef {
    vcsrepo { $datadir:
      ensure   => $repoensure,
      provider => $vcsprovider,
      source   => $source,
      require  => Package[$vcsprovider],
    }
  }
  else {
    vcsrepo { $datadir :
      ensure   => $repoensure,
      provider => $vcsprovider,
      source   => $source,
      revision => $release,
      require  => Package[$vcsprovider],
    }
  }

}
