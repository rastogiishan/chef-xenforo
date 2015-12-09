# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         XenForo database
# Recipe::              db
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

# MySQL/Percona
if node['xenforo']['use_bp_percona']
  node.set['bp-percona']['credidentials'] = ['xenforo', 'mysql', node['xenforo']['db']['data_bag_item']]
  node.set_unless['bp-percona']['innodb-buffer-pool-size'] = '256M'
  include_recipe 'bp-percona::_server'
else
  include_recipe 'mysql-chef_gem::default' unless `/opt/chef/embedded/bin/gem list`.include? 'mysql '

  mysql_db = Chef::EncryptedDataBagItem.load('xenforo', 'mysql')[node['xenforo']['db']['data_bag_item']]

  node.set['mysql']['server_root_password'] = mysql_db['root']
  node.set['mysql']['server_repl_password'] = mysql_db['replication']
  node.set['mysql']['server_debian_password'] = mysql_db['debian']
  include_recipe 'mysql::server'
end

include_recipe 'database::default'

db_cred = Chef::EncryptedDataBagItem.load('xenforo', 'mysql')

mysql_connection_info = { :host => 'localhost',
                          :username => 'root',
                          :password => db_cred[node['xenforo']['db']['data_bag_item']]['root'] }

node['xenforo']['names'].each do |db_name|
  cred = Chef::EncryptedDataBagItem.load('xenforo', 'db')[db_name]

  mysql_database cred['dbname']  do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user cred['username'] do
    connection mysql_connection_info
    password cred['password']
    action :create
  end

  ipaddresses = []
  search(:node, "roles:xenforo AND tags:id-#{db_name} AND chef_environment:#{node.chef_environment}").each do |xnode|
    ipaddresses << xnode['xenforo']['private_ip']
  end

  ipaddresses.each do |ipaddress|
    mysql_database_user cred['username'] do
      connection mysql_connection_info
      password cred['password']
      database_name cred['dbname']
      host ipaddress
      privileges ['select', 'lock tables', 'insert', 'update', 'delete',
                  'create', 'drop', 'index', 'alter']
      action :grant
    end
  end

  # xenforo statistic api user
  next if false == cred.key?('xfsapi_username') || false == cred.key?('xfsapi_password')

  ipaddresses = []
  search(:node, "roles:xenforo-statistic-api AND chef_environment:#{node.chef_environment}").each do |xnode|
    ipaddresses << xnode['xenforo']['private_ip']
  end

  ipaddresses.each do |ipaddress|
    mysql_database_user cred['xfsapi_username'] do
      connection mysql_connection_info
      password cred['xfsapi_password']
      database_name cred['dbname']
      host ipaddress
      privileges ['select']
      action :grant
    end
  end
end
