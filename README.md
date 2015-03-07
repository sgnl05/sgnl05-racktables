# racktables

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with racktables](#setup)
    * [What racktables affects](#what-racktables-affects)
    * [Beginning with RackTables module](#beginning-with-racktables-module)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This Puppet module installs RackTables, along with Apache, PHP, MySQL.

## Module Description

RackTables is nifty and robust solution for datacenter and server room asset management. It helps document hardware assets, network addresses, space in racks, networks configuration and much much more.

Use this module to install a new instance of RackTables. The module will also install Apache, PHP, MySQL (optional) and some other dependencies for RackTables (php packages mostly).

WARNING:
Use this module on NEW servers! 
Existing databases, webserver configs and RackTables installations will be replaced or purged.

## Setup

### What racktables affects

* Apache - Any existing config will be purged or replaced.
* MySQL - Existing databases and settings might be replaced.
* RackTables - Existing RackTable files might be replaced.

### Beginning with RackTables module

To install RackTables version 0.20.10 with the default parameters:

```puppet
   class { '::racktables':
     vhost   => 'racktables.example.com',
     release => 'RackTables-0.20.10',
   }
```

As soon as Puppet is done installing, go to vhost address and append ?module=installer to the vhost URL (Example URL: https://racktables.example.com/?module=installer). From there follow the RackTables installation steps (7 in total).

Default database settings are:
* database: racktables_db
* username: racktables_user
* password: racktables_pass

These values can be changed by adding parameters 'mysqldb', 'mysqluser' and 'mysqluserpw' to the ::racktables class (See more [examples](#examples)).

Handling the permissions of secret.php at installation step 3 and 4 of can be assisted by Puppet. Use parameter 'secretfile' on the ::racktables class and set it to "writable" on step 3 and "readonly" on step 4. Remember to run "puppet agent -t" on the target server after each of these steps.

#### Examples

Install RackTables with a new local database:

```puppet
   class { '::racktables':
     vhost       => 'racktables.example.com',
     release     => 'RackTables-0.20.10',
     install_db  => true,
     db_name     => 'racktables',
     db_username => 'racktables',
     db_password => 'make_a_strong_password',
   }
```

Install RackTables, using a remote database with existing RackTables data:

```puppet
   class { '::racktables':
     vhost       => 'racktables.example.com',
     release     => 'RackTables-0.20.10',
     db_name     => 'example_db_name',
     db_username => 'example_username',
     db_password => 'example_password',
     db_host     => 'database.example.com',
     secretfile  => 'template',
   }
```

Make sure there's a DNS entry for your vhost. After 'puppet agent -t' run on target machine, go to the vhost URL and follow the onscreen installation instructions.

## Usage

###Classes and Defined Types

####Class: `racktables`

#####`secretfile`

Handles the inc/secret.php file. This can be put to good use during first time installation.

Available settings for this parameter are: "w" (writable), "r" (readonly) , "template" and "absent".

Set this attribute to "w" while installing RackTables and "r" (for readonly) after installation step 4.

You can also set this to "template" to use the template included with this module.

"absent" setting removes the file.

Defaults to undef, which results in file not being created or permissions not being modified.

#####`vhost`

The virtual host address to use for your racktables installation. Requires a valid DNS entry.
Defaults to 'racktables.example.com'.

#####`release`

Selects what RackTables version to download. The version is pulled from https://github.com/RackTables/racktables/tree/REVISION (Revision = Git revision TAG).
The RackTables project on GitHub has (so far) tagged every release with "RackTables-[version]".
You can automatically upgrade the racktables version by modifying this attribute to a higher version number.
Defaults to 'undef', which results in the default repo being downloaded. After first download, 'undef' setting will not modify local files even if the remote repo is updated.

#####`install_db`
Boolean. Set to 'true' to make this module install a mysql database on the target server. 
Defaults to 'false'.

#####`db_username`

Sets the mysql username for the racktables database.
Defaults to 'racktables_user'.

#####`db_password`

Sets the password for the user defined in param "mysqluser".
Defaults to 'racktables_pass'. 

#####`db_name`

Sets the name of the database for racktables.
Defaults to 'racktables_db'.

#####`db_host`

Sets the name of the database to connect to.
Defaults to 'localhost'.

#####`db_rootpw`

Sets the root password on MySQL.
Defaults to undef.

#####`ssl_cert`

Specifies the location of SSL certification.
Defaults to whatever the puppetlabs-apache module defines as default.

#####`ssl_key`

Specifies the location of the SSL key.
Defaults to whatever the puppetlabs-apache module defines as default.

#####`apacheuser`

Specifies the apache user. Used for setting permissions to inc/secret.php.
Defaults to 'apache' for RedHat/CentOS and 'www-data' for Debian/Ubuntu.

#####`datadir`

Specifies the installation path of RackTables.
Defaults to '/usr/local/share/RackTables'.

#####`packages`

Defines what prerequisities to install.
Defaults are operating system spesific. See params.pp for details.

#####`repoensure`
Specify the ensure parameter for vcsrepo. Setting this to 'latest' will always pull new commits to the GitHub repo, which is usefull for development environments. Use only 'present' for production installations!
Defaults to 'present'. Valid values are 'present' and 'latest'.

#####`vcsprovider`

Defines what vcs system to use for downloading RackTables.
Defaults to 'git'.

#####`source`

Path to the RackTables repo.
Defaults to 'https://github.com/RackTables/racktables.git'.

## Reference

###Classes

####Public Classes

* `racktables`: Starts the module and calls racktables::apache, racktables::mysql and racktables::install
* `racktables::apache`: Installs Apache and a spesified vhost
* `racktables::mysql`: Installs MySQL and sets up an empty database
* `racktables::install`: Pulls and installs RackTables from GitHub (or other specified source)
* `racktables::config`: Handles the inc/secret.php file

####Private Classes

* `racktables::params`: Default parameters

## Limitations

#####RHEL 7

Should work, but has not been tested.

## Development

###Contributing

Please use the issue tracker (https://github.com/sgnl05/sgnl05-racktables/issues) for any type of contribution. 
