Overview
--------

The reason for this projects existence is that there are currently many different puppet modules to manage MySQL but
they seem to cover different areas of its management. The current (9?) modules cover everything from installation and
configuration to custom queries.

The aim is to merge functionality and refactor (where appropriate) into a unified puppet module that covers all
of these areas of functionality.

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
