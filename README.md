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

This Puppet module installs the latest development version of RackTables, along with Apache, PHP and MySQL.

## Module Description

RackTables is nifty and robust solution for datacenter and server room asset management. It helps document hardware assets, network addresses, space in racks, networks configuration and much much more.

Use this module to install the latest development version of RackTables. The module will also install Apache, PHP, MySQL and some other dependencies for RackTables (php packages mostly).


WARNING:
This is not ment for production servers. Use this module on NEW servers for development or demo purposes only! 
Exsisting Apache, MySQL and RackTables installations might/will be overwritten.


## Setup

### What racktables affects

* Apache - Any exsisting config will be replaced or purged.
* MySQL - Existing databases and settings might get overwritten.

### Beginning with RackTables module

To install RackTables with the default parameters

```puppet
    class { '::racktables':
      secretwriteable => true,
      vhost           => 'racktables.example.com',
    }
```

As soon as puppet is done installing, go to vhost address and append ?module=installer to the URL (Example URL: http://racktables.example.com/?module=installer). From there follow the RackTables installation steps, 7 in total.

Default database settings are:
* database: racktables_db
* username: racktables_user
* password: racktables_pass

These values can be changed by adding parameters mysqldb, mysqluser and mysqluserpw to the ::racktables class (See more [examples](#examples)).

When you get to RackTables installation step 4 (of 7), remove the `secretwriteable` parameter from the ::racktables class (or set it to false). Next, re-run puppet and then finnish the rest of the installation steps.

#### Examples

Set a root password for your mysql installation (default password is "strongpassword" if undefined):

```puppet
    class { '::racktables':
      secretwriteable => true,
      mysqlrootpw     => 'change.me123XXXabc',
      vhost           => 'racktables.example.com',
    }
```

Proper installation with recommended parameters:

```puppet
    class { '::racktables':
      secretwriteable => true,
      vhost           => 'racktables.example.com',
      mysqlrootpw     => 'strongpassword123.XXXabc',
      mysqldb         => 'racktables',
      mysqluser       => 'racktables',
      mysqluserpw     => 'otherstrongpasswordXXX123XXX.abc',
      mysqlhost       => 'localhost',
    }
```

When installations done, dont forget to set secretwriteable to false (or remove the whole parameter). You can also remove the mysqlrootpw parameter, as it is now stored in /root/.my.cnf on the local server.

In other words, after installation is done your class should look like this:

```puppet
    class { '::racktables':
      vhost           => 'racktables.example.com',
      mysqldb         => 'racktables',
      mysqluser       => 'racktables',
      mysqluserpw     => 'otherstrongpasswordXXX123XXX.abc',
      mysqlhost       => 'localhost',
    }
```


## Reference

###Classes

####Public Classes

* `racktables`: Starts the module and calls racktables::install, racktables::apache and racktables::mysql

####Private Classes

* `racktables::install`: Pulls and installs RackTables from https://github.com/RackTables/racktables.git
* `racktables::apache`: Installs Apache and a vhost for Racktables
* `racktables::mysql`: Install MySQL and sets up a database for Racktables


## Limitations

###RHEL/CentOS 5

Package installation for PHP won't work

###RHEL/CentOS 7

Should work, but has not been tested

###Ubuntu 12.04

Should work, but has not been tested

###Ubuntu 14.04

Should world, but has not been tested

## Development

###Contributing

Feel free to contact me if you have suggestions or patches.

## Release Notes/Contributors/Etc **Optional**

* 0.1.0 Initial release
