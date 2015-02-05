## 2014-09-05 Release 0.2.0

##Updates

Added ability to select what RackTables version to download.

Changed secret file handling.

Updated puppetlabs-mysql requirements to version 3.1.0. This should fix CentOS 7 support (not tested).


## 2014-09-05 Release 0.1.4

###Updates

php5-curl dependency for Debian/Ubuntu.

## 2014-09-05 Release 0.1.3

###Updates

php5-ldap dependency for Debian/Ubuntu. Jens Rosenbloom (#2)

Changed attribute name 'secretwriteable' to 'secretfile' and changed the installation routine to be more intuitive regarding this file.  

## 2014-08-01 Release 0.1.2

###Updates

Added support for Debian 7 by setting 'mpm_module' to "prefork" when calling apache install.

Removed Redhat/CentOS 7 support in metadata.json as current puppetlabs-mysql version is broken on CentOS 7.


## 2014-07-31 Release 0.1.1

###Summary

Updated documentation.


## 2014-07-30 Release 0.1.0

###Summary

First release.
