# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Installs Apache for xenForo
# Recipe::              _apache
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

fail "Only one name allowed" unless  node['xenforo']['names'].length == 1

puts '---------------------------------------------------------'
puts '---------------------------------------------------------'
puts node['xenforo']['names']
puts node['xenforo']['names'][0]
puts '---------------------------------------------------------'
puts '---------------------------------------------------------'

node.default['apache']['default_site_enabled'] = false
node.default['apache']['serversignature'] = 'Off'

include_recipe 'apache2::mod_php5'

if node['xenforo']['enable_ssl']
  node.default['apache']['mod_ssl']['cipher_suite'] = node['xenforo']['sslciphersuite']

  include_recipe 'apache2::mod_ssl'

  certificate_manage node['xenforo']['ssl_data_bag_item'] do
  end
end

if node['xenforo']['enable_htpasswd']
  ht_user =  Chef::EncryptedDataBagItem.load('xenforo', 'htpasswd')
  htpasswd node['xenforo']['htpasswd_file'] do
    user ht_user['names'][0]
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

directory node['xenforo']['php']['session']['save_path'] do
  owner node['apache']['user']
  group node['apache']['group']
  mode '0700'
  recursive true
  action :create
end

directory node['xenforo']['php']['upload_tmp_dir'] do
  owner node['apache']['user']
  group node['apache']['group']
  mode '0700'
  recursive true
  action :create
end

directory "/etc/php5/#{node['xenforo']['names'][0]}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/etc/php5/#{node['xenforo']['names'][0]}/php.ini" do
  source 'php_ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[apache2]', :delayed
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

template '/etc/apache2/sites-available/001-default' do
  source 'site_default.erb'
  variables('redirect_to' => r_url)
  notifies :restart, 'service[apache2]', :delayed
end

template "/etc/apache2/sites-available/xenforo-#{node['xenforo']['names'][0]}" do
  source 'site_xenforo.erb'
  variables('phpinidir' =>  "/etc/php5/#{node['xenforo']['names'][0]}")
  notifies :restart, 'service[apache2]', :delayed
end

template '/etc/apache2/sites-available/maintenance' do
  source 'site_maintanence.erb'
  variables('phpinidir' =>  "/etc/php5/#{node['xenforo']['names'][0]}")
end

apache_site "xenforo-#{node['xenforo']['names'][0]}"
apache_site '001-default'
