#
class racktables::apache inherits racktables {

  class { '::apache':
    default_mods        => false,
    default_confd_files => false,
    default_vhost       => false,
    default_ssl_vhost   => false,
    mpm_module          => 'prefork',
  }

  class {'::apache::mod::php': }
  class {'::apache::mod::auth_basic': }
  class {'::apache::mod::authnz_ldap': }

  apache::vhost { "${vhost}-http":
    servername      => "${vhost}",
    port            => '80',
    docroot         => "${datadir}/wwwroot",
    access_log_file => "${vhost}_access_log",
    error_log_file  => "${vhost}_error_log",
    redirect_source => ['/'],
    redirect_dest   => ["https://${vhost}/"],
    redirect_status => ['temp'],
    require         => vcsrepo[$datadir],
  }

  apache::vhost { "${vhost}-https":
    servername      => "${vhost}",
    port            => '443',
    docroot         => "${datadir}/wwwroot",
    access_log_file => "${vhost}_access_ssl_log",
    error_log_file  => "${vhost}_error_ssl_log",
    ssl             => true,
    require         => vcsrepo[$datadir],
    override        => 'AuthConfig',
  }

}
