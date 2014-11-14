# Encoding: UTF-8
# Cookbook Name::       xenforo
# Description::         Bigpoint xenForo forum
# Recipe::              server
# Author::              Thorsten Winkler (<t.winkler@bigpoint.net>)

fail 'Only one name allowed' unless node['xenforo']['names'].length == 1
fail 'Primary name is empty' if node['xenforo']['names'][0].empty?

include_recipe 'apache2-wrapper::default'
include_recipe 'xenforo::_apache'

status_script = '/usr/local/bin/board_deploy_status.sh'

%w(git php5-mysql php5-gd php5-memcached php5-mcrypt libssh2-php php5-imagick).each do |pkg|
  package pkg do
    action :install
  end
end

directory '/root' do
  owner 'root'
  mode '0700'
  action :create
end

directory '/root/.ssh' do
  owner 'root'
  mode '0700'
  action :create
end

group node['xenforo']['htdocs_group'] do
  action :create
end

keys = Chef::EncryptedDataBagItem.load('xenforo', 'ssh')

file '/root/.ssh/id_rsa' do
  owner 'root'
  mode '0600'
  content keys['root']['secretkey']
end

file '/root/.ssh/id_rsa.pub' do
  owner 'root'
  mode '0644'
  content keys['root']['publickey']
end

if node['xenforo']['use_nexus_deploy']
  include_recipe 'xenforo::_deploy_nexus'
else
  include_recipe 'xenforo::_deploy_git'
end

if File.exist?(node['xenforo']['htdocs_xenforo'])
  %w(data internal_data).each do |dir|
    directory "#{node['xenforo']['htdocs_xenforo']}/#{dir}" do
      owner node['apache']['user']
      group node['xenforo']['htdocs_group']
      mode '0775'
    end
  end

  ip_db = nil
  port_db = nil
  search(:node, "roles:xenforodb AND tags:id-#{node['xenforo']['names'][0]}").each do |dbnode|
    ip_db = dbnode['ipaddress']
    port_db = dbnode['mysql']['port']
    log "Found DB on #{ip_db}:#{port_db}"
  end

  ip_mem = nil
  port_mem = nil
  search(:node, "roles:xenforomem AND tags:id-#{node['xenforo']['names'][0]}").each do |memnode|
    ip_mem = memnode['ipaddress']
    port_mem = memnode['memcached']['port']
    log "Found memcache on #{ip_mem}:#{port_mem}"
  end

  # social
  if node['xenforo']['social']['data_bag_item'].nil?
    social = nil
  else
    social = Chef::EncryptedDataBagItem.load('xenforo', 'social')[node['xenforo']['social']['data_bag_item']]
  end

  unless ip_db.nil?
    cred = Chef::EncryptedDataBagItem.load('xenforo', 'db')
    if node['xenforo']['cdn']['external_data_url'].nil?
      cdn_password = nil
    else
      cdn_password = Chef::EncryptedDataBagItem.load('xenforo', 'cdn')\
        [node['xenforo']['cdn']['provider']][node['xenforo']['cdn']['user']]['password']
    end
    template "#{node['xenforo']['htdocs_xenforo']}/library/config.php" do
      owner node['apache']['user']
      group node['apache']['group']
      mode '0644'
      variables('dbhost' => ip_db,
                'dbport' => port_db,
                'dbuser' => cred[node['xenforo']['names'][0]]['username'],
                'dbpass' => cred[node['xenforo']['names'][0]]['password'],
                'dbname' => cred[node['xenforo']['names'][0]]['dbname'],
                'cookie_domain' => node['xenforo']['cookie_domain'],
                'memip' => ip_mem,
                'memport' => port_mem,
                'enable_mail' => node['xenforo']['enable_mail'],
                'super_admins' => node['xenforo']['super_admins'],
                'externalDataPath' => node['xenforo']['external_data_path'],
                'javaScriptUrl' => node['xenforo']['java_script_url'],
                'externalDataUrl' => node['xenforo']['cdn']['external_data_url'],
                'cdn_host' => node['xenforo']['cdn']['host'],
                'cdn_port' => node['xenforo']['cdn']['port'],
                'cdn_user' => node['xenforo']['cdn']['user'],
                'cdn_password' => cdn_password,
                'social' => social,
                'debug' => node['xenforo']['debug'],
                'short_name' => node['xenforo']['names'][0])
      source 'config_php.erb'
      only_if { File.exist?("#{node['xenforo']['htdocs_xenforo']}/library") }
    end
  end
end

# Status script
template status_script do
  source 'board_deploy_status.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables('repos' => [node['xenforo']['repository_destination'],
                        node['xenforo']['repository_addons_destination']],
            'pending_file' => node['xenforo']['repo_changed_file'])
end

execute 'generate_status_script' do
  command "#{status_script} > #{node['xenforo']['htdocs_xenforo']}/install/board_deploy_status.html"
  ignore_failure true
  action :nothing
end

%w(bg-professor.jpg icon-stern.png).each do |img|
  cookbook_file "#{node['xenforo']['htdocs_maintenance']}/maintenance/#{img}" do
    source img
    owner 'root'
    group node['apache']['group']
    mode '0644'
  end
end

template '/usr/sbin/maintenance.sh' do
  source 'maintenance_script.erb'
  variables('site_xenforo' => "xenforo-#{node['xenforo']['names'][0]}",
            'site_maintenance' => 'maintenance')
  owner 'root'
  group 'root'
  mode '0755'
end
