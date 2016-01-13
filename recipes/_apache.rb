# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Installs Apache for xenForo
# Recipe::              _apache
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

fail 'Only one name allowed' unless node['xenforo']['names'].length == 1
fail 'Primary name is empty' if node['xenforo']['names'][0] == ''

node.set_unless['bp-php']['session']['save_path'] = "#{node['apache']['docroot_dir']}/#{node['xenforo']['names'][0]}-sessions"
node.set_unless['bp-php']['upload_tmp_dir'] = "#{node['apache']['docroot_dir']}/#{node['xenforo']['names'][0]}-uploads"
node.set_unless['bp-php']['upload_max_filesize'] = node['xenforo']['upload_max_filesize']
node.set_unless['bp-php']['allow_url_fopen'] = 'On'
node.set_unless['bp-php']['session']['cookie_httponly'] = ''
node.set_unless['bp-php']['session']['cookie_secure'] = nil

site_default = '001-default'
site_xenforo = "xenforo-#{node['xenforo']['names'][0]}"
site_maintenance = 'maintenance'

node.default['apache']['default_site_enabled'] = false
node.default['apache']['serversignature'] = 'Off'

include_recipe 'bp-php::default'
include_recipe 'apache2::mod_php5'

if node['xenforo']['ssl']['enable']
  node.default['apache']['mod_ssl']['cipher_suite'] = node['xenforo']['ssl']['ciphersuite']

  certificate_manage node['xenforo']['ssl']['data_bag_item'] do
  end

  include_recipe 'apache2::mod_ssl'
end

if node['xenforo']['enable_htpasswd']
  ht_user = Chef::EncryptedDataBagItem.load('xenforo', 'htpasswd')
  htpasswd node['xenforo']['htpasswd_file'] do
    user ht_user['name']
    password ht_user['password']
  end
end

directory node['xenforo']['htdocs_xenforo'] do
  owner node['apache']['user']
  group node['apache']['group']
  mode '0555'
  recursive true
  action :create
end

directory node['bp-php']['session']['save_path'] do
  owner node['apache']['user']
  group node['apache']['group']
  mode '0700'
  recursive true
  action :create
end

directory node['bp-php']['upload_tmp_dir'] do
  owner node['apache']['user']
  group node['apache']['group']
  mode '0700'
  recursive true
  action :create
end

apache_module 'rewrite' do
  enable true
end

# Det. redirect URL
if node['xenforo']['redirect_url'].nil?
  r_url = "#{node['xenforo']['server_name']}/"
else
  r_url = node['xenforo']['redirect_url']
end

template "#{node['apache']['dir']}/sites-available/#{site_default}" do
  source 'site_default.erb'
  variables('redirect_to' => r_url,
            'ssl_enable' => node['xenforo']['ssl']['enable'],
            'ssl_private' => "/etc/ssl/private/#{node['fqdn']}.key",
            'ssl_public' => "/etc/ssl/certs/#{node['fqdn']}.pem",
            'ca_cert' => "/etc/ssl/certs/#{node['hostname']}-bundle.crt",
            'ssl_protocol' => node['xenforo']['ssl']['protocol'],
            'ssl_ciphersuite' => node['xenforo']['ssl']['ciphersuite'],
            'custom_log' => node['xenforo']['customlog'],
            'error_log' => node['xenforo']['errorlog'])
  notifies :restart, 'service[apache2]', :delayed
end

if node['xenforo']['install_allow_from'].is_a? Array
  install_allow_from = node['xenforo']['install_allow_from'].empty? \
                       ? nil : node['xenforo']['install_allow_from']
elsif node['xenforo']['install_allow_from'].is_a? String
  Chef::Application.fatal!('install_allow_from contains white spaces', 42) if node['xenforo']['install_allow_from'].match(/\s/)
  install_allow_from = node['xenforo']['install_allow_from'].empty? \
                       ? nil : [node['xenforo']['install_allow_from']]
else
  Chef::Application.fatal!('install_allow_from not of the right type', 42)
end

template "#{node['apache']['dir']}/sites-available/#{site_xenforo}" do
  source 'site_xenforo.erb'
  variables('instance_name' => node['xenforo']['names'][0],
            'server_name' => node['xenforo']['server_name'],
            'server_aliases' => node['xenforo']['server_aliases'],
            'htdocs' => node['xenforo']['htdocs_xenforo'],
            'phpinidir' => node['bp-php']['ini_path'],
            'htdocs' => node['xenforo']['htdocs_xenforo'],
            'htpasswd' => node['xenforo']['enable_htpasswd'],
            'htpasswd_file' => node['xenforo']['htpasswd_file'],
            'install_allow_from' => install_allow_from,
            'custom_log' => node['xenforo']['customlog'],
            'error_log' => node['xenforo']['errorlog'],
            'ssl_enable' => node['xenforo']['ssl']['enable'],
            'ssl_private' => "/etc/ssl/private/#{node['fqdn']}.key",
            'ssl_public' => "/etc/ssl/certs/#{node['fqdn']}.pem",
            'ca_cert' => "/etc/ssl/certs/#{node['hostname']}-bundle.crt",
            'ssl_protocol' => node['xenforo']['ssl']['protocol'],
            'ssl_ciphersuite' => node['xenforo']['ssl']['ciphersuite'])
  notifies :restart, 'service[apache2]', :delayed
end

# Maintainance
directory node['xenforo']['htdocs_maintenance'] do
  owner 'root'
  group node['apache']['group']
  mode '0755'
  recursive true
  action :create
end

template "#{node['xenforo']['htdocs_maintenance']}/index.html" do
  source 'maintenance.erb'
  owner 'root'
  group node['apache']['group']
  mode '0644'
  variables('maintenance_image' => '/maintenance/bg-professor.jpg',
            'icon_image' => '/maintenance/icon-stern.png')
end

directory "#{node['xenforo']['htdocs_maintenance']}/maintenance" do
  owner 'root'
  group node['apache']['group']
  mode '0755'
  recursive true
  action :create
end

template "#{node['apache']['dir']}/sites-available/#{site_maintenance}" do
  source 'site_maintanence.erb'
  variables('phpinidir' => node['bp-php']['ini_path'],
            'htdocs' => node['xenforo']['htdocs_maintenance'],
            'ssl_enable' => node['xenforo']['ssl']['enable'],
            'ssl_private' => "/etc/ssl/private/#{node['fqdn']}.key",
            'ssl_public' => "/etc/ssl/certs/#{node['fqdn']}.pem",
            'ca_cert' => "/etc/ssl/certs/#{node['hostname']}-bundle.crt",
            'ssl_protocol' => node['xenforo']['ssl']['protocol'],
            'ssl_ciphersuite' => node['xenforo']['ssl']['ciphersuite'],
            'custom_log' => node['xenforo']['customlog'],
            'error_log' => node['xenforo']['errorlog'])
  notifies :restart, 'service[apache2]', :delayed
end

apache_site site_xenforo
apache_site site_default
