# mysql.pp
# Parts Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# Parts Copyright Rgaevert

class mysql::server ( $type='oracle', $multi=false ) {

	include mysql::params
	include mysql::repo
	include mysql::install
	include mysql::config

	Class['params'] ->
	  Class['repo'] ->
	  Class['install'] ->
	  Class['config']

	if ($multi) {
	  	include mysql::multi
	  	Class['config'] -> Class['multi']
	} else {
	  	include mysql::service
	  	include mysql::functions
	  	Class['config'] -> Class['service'] -> Class['functions']
	}

	# What if we don't have munin?
	# munin::plugin {
	# 	[mysql_bytes, mysql_queries, mysql_slowqueries, mysql_threads]:
	# 		config => "env.mysqlopts --defaults-file=/etc/mysql/debian.cnf\nuser root"
	# }

	# Collect all databases and users
	Mysql_database<<||>>
	Mysql_user<<||>>
	Mysql_grant<<||>>

}
