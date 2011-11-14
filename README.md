This WILL be superseded by puppetlabs' official puppet-mysql module
-------------------------------------------------------------------

See puppetlabs/puppetlabs-mysql

Puppetlabs is producing its own module superior to most of the community
driven modules.

Overview
--------

The reason for this projects existence is that there are currently many different puppet modules to manage MySQL but
they seem to cover different areas of its management. The current (9?) modules cover everything from installation and
configuration to custom queries.

The aim is to merge functionality and refactor (where appropriate) into a unified puppet module that covers all
of these areas of functionality.

All credit goes to DavidS and rgaevert for their excellent implementations. I simply merged what was already existing.

Usage
=====

MySQL Installation
------------------

Install oracle branch, do not allow for multiple instances per host.
```
class {
	'mysql::server':
		type => 'oracle',
		multi => false,
}
```

Install mariaDB branch, configure multiple instances.

```
class {
	'mysql::server':
		type => 'mariadb',
		multi => true,
}

mysql::multi::instance {
  'mysqld1':
    groupnr      => 1,
    bind_address => '0.0.0.0',
    port         => 3307;
  'mysqld2':
    groupnr      => 2,
    bind_address => '0.0.0.0',
    port         => 3308;
  'mysqld3':
    groupnr      => 3,
    bind_address => '0.0.0.0',
    port         => 3309,
    ensure       => 'stopped';
}
```

MySQL Configuration
-------------------

Change settings in your MySQL configuration

```
mysql::config::param {
  'bind-address':
    section => 'mysqld',
    value   => '0.0.0.0';
}
```

```
mysql::config::param {
  'bind-address1':
    section => 'mysqld1',
    param   => 'bind-address',
    value   => '0.0.0.0';
}
```

Database
--------

Ensure a database is created

```
mysql_database { "mydb":
	ensure => present,
	name => "mydb", # [OPTIONAL namevar]
	defaults => "/etc/mysql/debian.cnf", # [OPTIONAL]
}
```

Ensure a database is dropped

```
mysql_database { "mydb":
	ensure => absent,
	name => "mydb", # [OPTIONAL namevar]
}
```

Users
-----

Ensure a user is created (global)

```
mysql_user { "myuser@localhost":
	ensure => present,
	name => "myuser@localhost", # [OPTIONAL namevar]
	password_hash => "mysql_password() hash to use",
	defaults => "", # [OPTIONAL]
}
```

Grant rights to user

```
mysql_grant { "myuser@localhost/mydb":
	name => "myuser@localhost/mydb", # [OPTIONAL namevar]
	privileges => all,
	defaults => "", # [OPTIONAL]
}
```

Of course you can grant individual rights via an array.


State of the puppet-mysql scene
-------------------------------

These are some notes about other authors' puppet-mysql modules.

DavidS/puppet-mysql

- Pretty comprehensive administration tools.
- Database create/drop via mysqladmin.
- User create/drop and grant, assembled SQL.
- Custom providers.

example42/puppet-modules/mysql

- Install/remove.
- Grant.
- Custom queries.
- Configuration (my.cnf).
- Class based.

ghoneycutt/puppet-mysql

- Based completely on custom queries.
- Basic package install.

rgaevert/puppet-mysql

- Very detailed installation
- Configuration (my.cnf)

rocha/puppet-mysql

- Custom SQL via load .sql
- Grant
- Basic package install.

Summary
-------

- DavidS is the most comprehensive for administration of the databases themselves.
- rgaevert provides the most comprehensive installation routine.
- example42 and rgaevert have very good my.cnf parameter setting.

Plan
----

- Use DavidS as the basis for a new module
- incorporate rgaevert's installation routine
- determine the best design for my.cnf settings and incorporate.
- provide custom query based on either ghoneycutt's mysql::do or example42's mysql::query

Additional Features?
--------------------

- Simple backup via mysqlhotcopy script?
- What next?
