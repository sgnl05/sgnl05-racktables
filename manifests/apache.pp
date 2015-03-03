# Installs apache and racktables vhost
class racktables::apache {

  class { '::apache':
    default_mods        => false,
    default_confd_files => false,
    default_vhost       => false,
    default_ssl_vhost   => false,
    mpm_module          => 'prefork',
  }

  class {'::apache::mod::php': }

  apache::vhost { "${racktables::vhost}-http":
    servername      => $racktables::vhost,
    port            => '80',
    docroot         => "${racktables::datadir}/wwwroot",
    access_log_file => "${racktables::vhost}_access_log",
    error_log_file  => "${racktables::vhost}_error_log",
    redirect_source => ['/'],
    redirect_dest   => ["https://${racktables::vhost}/"],
    redirect_status => ['temp'],
    require         => Vcsrepo[$racktables::datadir],
  }

  apache::vhost { "${racktables::vhost}-https":
    servername      => $racktables::vhost,
    port            => '443',
    docroot         => "${racktables::datadir}/wwwroot",
    access_log_file => "${racktables::vhost}_access_ssl_log",
    error_log_file  => "${racktables::vhost}_error_ssl_log",
    ssl             => true,
    require         => Vcsrepo[$racktables::datadir],
  }

}
